#!/bin/bash
# コマンドログ関連のユーティリティ関数

# ログファイルの内容をフィルタして表示
function log_filter() {
    local filter_type="$1"
    local pattern="$2"
    local date_pattern="${3:-$(date +%Y%m%d)}"
    local log_file="${LOG_DIR}/commands_${date_pattern}.log"

    if [[ ! -f "$log_file" ]]; then
        echo "ログファイルが見つかりません: $log_file"
        return 1
    fi

    case "$filter_type" in
    "errors" | "error")
        echo "=== エラーのあったコマンド ==="
        grep -A 10 -B 5 "Exit Code: [^0]" "$log_file" | grep -v "Exit Code: 0"
        ;;
    "user" | "pwd")
        echo "=== 特定のディレクトリでのコマンド ==="
        grep -A 10 -B 2 "PWD: .*$pattern" "$log_file"
        ;;
    "time" | "timeline")
        echo "=== 時系列表示 ==="
        grep "Time:\|Command:" "$log_file" | sed 'N;s/\n/ /'
        ;;
    "summary")
        echo "=== コマンド実行サマリー ==="
        echo "総コマンド数: $(grep -c "Command:" "$log_file")"
        echo "エラー数: $(grep -c "Exit Code: [^0]" "$log_file")"
        echo "最も多く使用されたコマンド:"
        grep "Command:" "$log_file" | sed 's/Command: //' | awk '{print $1}' | sort | uniq -c | sort -nr | head -10
        ;;
    *)
        echo "使い方: log_filter <type> [pattern] [date]"
        echo "  type: errors, user, time, summary"
        echo "  pattern: 検索パターン (user タイプの場合のみ)"
        echo "  date: 日付 (YYYYMMDD形式, デフォルトは今日)"
        ;;
    esac
}

# 複数日のログを横断検索
function log_grep_multi() {
    local pattern="$1"
    local days="${2:-7}"

    if [[ -z "$pattern" ]]; then
        echo "使い方: log_grep_multi <パターン> [日数]"
        return 1
    fi

    echo "=== 過去${days}日間のログから検索: '$pattern' ==="

    for i in $(seq 0 $((days - 1))); do
        local date=$(date -d "$i days ago" +%Y%m%d)
        local log_file="${LOG_DIR}/commands_${date}.log"

        if [[ -f "$log_file" ]]; then
            local matches=$(grep -c "$pattern" "$log_file" 2>/dev/null || echo "0")
            if [[ "$matches" -gt 0 ]]; then
                echo ""
                echo "--- $date ($matches件) ---"
                grep -n --color=auto "$pattern" "$log_file"
            fi
        fi
    done
}

# ログファイルのバックアップ
function log_backup() {
    local backup_dir="${LOG_DIR}/backup"
    local date_suffix=$(date +%Y%m%d_%H%M%S)

    mkdir -p "$backup_dir"

    echo "ログファイルをバックアップしています..."
    tar -czf "${backup_dir}/logs_backup_${date_suffix}.tar.gz" -C "$LOG_DIR" *.log 2>/dev/null

    if [[ $? -eq 0 ]]; then
        echo "バックアップ完了: ${backup_dir}/logs_backup_${date_suffix}.tar.gz"
    else
        echo "バックアップに失敗しました"
        return 1
    fi
}

# 今日のコマンド使用頻度を表示
function log_today_stats() {
    local today=$(date +%Y%m%d)
    local log_file="${LOG_DIR}/commands_${today}.log"

    if [[ ! -f "$log_file" ]]; then
        echo "今日のログファイルが見つかりません"
        return 1
    fi

    echo "=== 今日のコマンド統計 ($today) ==="
    echo ""

    echo "実行時間帯の分布:"
    grep "Time:" "$log_file" | sed 's/Time: [0-9-]* //' | cut -d: -f1 | sort | uniq -c | sort -nr
    echo ""

    echo "実行回数の多いコマンド (Top 10):"
    grep "Command:" "$log_file" | sed 's/Command: //' | awk '{print $1}' | sort | uniq -c | sort -nr | head -10
    echo ""

    echo "最も作業時間の長いディレクトリ:"
    grep "PWD:" "$log_file" | sed 's/PWD: //' | sort | uniq -c | sort -nr | head -5
    echo ""

    local total_commands=$(grep -c "Command:" "$log_file")
    local unique_commands=$(grep "Command:" "$log_file" | sed 's/Command: //' | awk '{print $1}' | sort | uniq | wc -l)
    echo "総コマンド数: $total_commands"
    echo "ユニークコマンド数: $unique_commands"
}

# 特定のコマンドの実行ログを表示
function log_trace_command() {
    local cmd="$1"
    local days="${2:-7}"

    if [[ -z "$cmd" ]]; then
        echo "使い方: log_trace_command <コマンド名> [過去の日数]"
        return 1
    fi

    echo "=== '$cmd' の実行履歴 (過去${days}日間) ==="

    for i in $(seq 0 $((days - 1))); do
        local date=$(date -d "$i days ago" +%Y%m%d)
        local log_file="${LOG_DIR}/commands_${date}.log"

        if [[ -f "$log_file" ]]; then
            local matches=$(grep -c "Command: $cmd" "$log_file" 2>/dev/null || echo "0")
            if [[ "$matches" -gt 0 ]]; then
                echo ""
                echo "--- $date ($matches回実行) ---"
                grep -A 15 "Command: $cmd" "$log_file" | grep -E "Time:|PWD:|Command:|Exit Code:" | head -20
            fi
        fi
    done
}

# エラーのあったコマンドのみを表示
function log_errors_only() {
    local days="${1:-1}"

    echo "=== エラーのあったコマンド (過去${days}日間) ==="

    for i in $(seq 0 $((days - 1))); do
        local date=$(date -d "$i days ago" +%Y%m%d)
        local log_file="${LOG_DIR}/commands_${date}.log"

        if [[ -f "$log_file" ]]; then
            echo ""
            echo "--- $date ---"
            # Exit Code が 0 以外のエントリを抽出
            awk '
                /===== Command Log =====/ { 
                    record = ""; 
                    recording = 1; 
                }
                recording && /===== End of Command =====/ { 
                    if (record ~ /Exit Code: [^0]/) {
                        print record;
                    }
                    recording = 0;
                }
                recording { 
                    record = record $0 "\n"; 
                }
            ' "$log_file"
        fi
    done
}

# エイリアスの定義
alias lfilter='log_filter'
alias lgrep='log_grep_multi'
alias lbackup='log_backup'
alias lstats_today='log_today_stats'
alias ltrace='log_trace_command'
alias lerrors='log_errors_only'

