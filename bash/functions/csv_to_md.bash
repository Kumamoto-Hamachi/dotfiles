# CSV to Markdown table converter
# Usage:
#   csv_to_md file.csv           # ファイルを変換
#   cat file.csv | csv_to_md     # パイプで入力
#   csv_to_md -d ';' file.csv    # デリミタを指定

csv_to_md() {
    local delimiter=','
    local input_file=""

    # 引数の解析
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -d|--delimiter)
                delimiter="$2"
                shift 2
                ;;
            -h|--help)
                echo "Usage: csv_to_md [-d delimiter] [file]"
                echo "  -d, --delimiter  CSVのデリミタを指定（デフォルト: ,）"
                echo "  file             入力ファイル（省略時は標準入力から読み込み）"
                return 0
                ;;
            *)
                input_file="$1"
                shift
                ;;
        esac
    done

    # 入力ソースの決定
    local input
    if [[ -n "$input_file" ]]; then
        if [[ ! -f "$input_file" ]]; then
            echo "Error: ファイルが見つかりません: $input_file" >&2
            return 1
        fi
        input=$(cat "$input_file")
    else
        # 標準入力から読み込み
        input=$(cat)
    fi

    # 空入力チェック
    if [[ -z "$input" ]]; then
        echo "Error: 入力が空です" >&2
        return 1
    fi

    # awkでMarkdownテーブルに変換
    echo "$input" | awk -v FS="$delimiter" '
    NR == 1 {
        # ヘッダー行
        printf "|"
        for (i = 1; i <= NF; i++) {
            gsub(/^[ \t]+|[ \t]+$/, "", $i)  # trim
            printf " %s |", $i
        }
        printf "\n|"
        # セパレーター行
        for (i = 1; i <= NF; i++) {
            printf " --- |"
        }
        printf "\n"
        next
    }
    {
        # データ行
        printf "|"
        for (i = 1; i <= NF; i++) {
            gsub(/^[ \t]+|[ \t]+$/, "", $i)  # trim
            printf " %s |", $i
        }
        printf "\n"
    }'
}
