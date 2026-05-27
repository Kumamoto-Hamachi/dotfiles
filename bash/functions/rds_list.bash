<< 'COMMENTOUT'
# 全エンジン、全バージョン、tableで表示
rds_list

# PostgreSQLだけ、CSVで
rds_list -e psql -o csv

# MySQL Communityで 8.0.36 未満のインスタンスのみ
rds_list -e mysql -v 8.0.36

# PostgreSQLで 15.5 未満を CSV 出力
rds_list -e psql -v 15.5 -o csv
COMMENTOUT

rds_list() {
    local output_format="table"
    local engine="all"
    local max_version=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -e|--engine)        engine="$2"; shift 2 ;;
            -o|--output)        output_format="$2"; shift 2 ;;
            -v|--max-version)   max_version="$2"; shift 2 ;;
            -h|--help)
                cat <<'EOF'
Usage: rds_list [options]
  -e, --engine       psql | mysql | all   (default: all)
  -o, --output       table | csv          (default: table)
  -v, --max-version  指定バージョン未満のインスタンスのみ表示 (例: 14.10)
EOF
                return 0 ;;
            *) echo "Unknown option: $1" >&2; return 1 ;;
        esac
    done

    # エンジンのフィルタ式 (JMESPath)
    local engine_filter=""
    case "$engine" in
        psql)  engine_filter="[?Engine=='postgres']" ;;
        mysql) engine_filter="[?Engine=='mysql']" ;;
        all)   engine_filter="[]" ;;
        *) echo "Invalid engine: $engine (psql|mysql|all)" >&2; return 1 ;;
    esac

    case "$output_format" in
        table|csv) ;;
        *) echo "Invalid output: $output_format (table|csv)" >&2; return 1 ;;
    esac

    local query="DBInstances${engine_filter}.[DBInstanceIdentifier,Engine,EngineVersion,DBInstanceClass,ReadReplicaSourceDBInstanceIdentifier]"

    # JSONで取得 → TSV化 (Role判定はjq側で行う)
    local rows
    rows=$(aws rds describe-db-instances --query "$query" --output json \
            | jq -r '.[] | [.[0], .[1], .[2], .[3], (if .[4] then "replica" else "primary" end)] | @tsv')

    # max_version 未満のみ残す
    if [[ -n "$max_version" ]]; then
        rows=$(printf '%s\n' "$rows" | awk -F'\t' -v max="$max_version" '
            function vlt(a, b,   ax, bx, na, nb, i, av, bv) {
                na = split(a, ax, ".")
                nb = split(b, bx, ".")
                for (i = 1; i <= na || i <= nb; i++) {
                    av = (i <= na) ? ax[i]+0 : 0
                    bv = (i <= nb) ? bx[i]+0 : 0
                    if (av < bv) return 1
                    if (av > bv) return 0
                }
                return 0
            }
            NF && vlt($3, max) { print }
        ')
    fi

    # EngineVersion でバージョンソート (sort -V)
    rows=$(printf '%s\n' "$rows" | sort -t$'\t' -k3,3V)

    # 出力
    if [[ "$output_format" == "csv" ]]; then
        echo "DBInstanceIdentifier,Engine,EngineVersion,DBInstanceClass,Role"
        printf '%s\n' "$rows" | awk -F'\t' 'BEGIN{OFS=","} NF {print $1,$2,$3,$4,$5}'
    else
        {
            printf 'DBInstanceIdentifier\tEngine\tEngineVersion\tDBInstanceClass\tRole\n'
            printf '%s\n' "$rows"
        } | column -t -s $'\t'
    fi
}
