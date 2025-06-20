#!/bin/bash
# コマンドログ記録機能
#
# 使い方:
#   log_start    - ログ記録を開始
#   log_stop     - ログ記録を停止
#   log_status   - ログ記録の状態を確認
#   log_view     - 今日のログを表示
#   log_search   - ログを検索

# ログディレクトリの設定
export LOG_DIR="${HOME}/logs"
export LOG_ENABLED_FILE="${LOG_DIR}/.logging_enabled"

# ログディレクトリの作成
[[ ! -d "$LOG_DIR" ]] && mkdir -p "$LOG_DIR"

# ログ記録の開始
function log_start() {
    touch "$LOG_ENABLED_FILE"
    export LOGGING_ENABLED=1

    # scriptコマンドを使用する場合
    if [[ "$1" == "--script" ]]; then
        local log_file="${LOG_DIR}/terminal_$(date +%Y%m%d_%H%M%S).log"
        echo "scriptコマンドでログ記録を開始します: $log_file"
        echo "終了するには 'exit' を入力してください"
        script -f "$log_file"
    else
        echo "コマンドログ記録を開始しました"
        echo "ログファイル: ${LOG_DIR}/commands_$(date +%Y%m%d).log"
    fi
}

# ログ記録の停止
function log_stop() {
    rm -f "$LOG_ENABLED_FILE"
    unset LOGGING_ENABLED

    # フルセッションログの場合、新しいシェルを推奨
    if [[ -n "$FULL_SESSION_LOGGING" ]]; then
        echo "フルセッションログを停止しました"
        echo "完全に停止するには新しいシェルセッションを開始することを推奨します"
        echo "新しいbashを起動: bash"
        unset FULL_SESSION_LOGGING
    else
        echo "コマンドログ記録を停止しました"
    fi
}

# ログ記録の状態確認
function log_status() {
    if [[ -f "$LOG_ENABLED_FILE" ]]; then
        echo "ログ記録: 有効"
        echo "ログディレクトリ: $LOG_DIR"
        echo "今日のログファイル: ${LOG_DIR}/commands_$(date +%Y%m%d).log"
    else
        echo "ログ記録: 無効"
    fi
}

# コマンド実行前のログ記録
function log_command() {
    if [[ -f "$LOG_ENABLED_FILE" ]] && [[ -n "$BASH_COMMAND" ]]; then
        local log_file="${LOG_DIR}/commands_$(date +%Y%m%d).log"
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        local cmd="$BASH_COMMAND"

        # 除外するコマンドのパターン
        if [[ ! "$cmd" =~ ^(log_|PS1=|PROMPT_COMMAND=|_.*) ]]; then
            {
                echo "===== Command Log ====="
                echo "Time: $timestamp"
                echo "User: $USER"
                echo "Host: $HOSTNAME"
                echo "PWD: $PWD"
                echo "Command: $cmd"
                echo "-----"
            } >>"$log_file"
        fi
    fi
}

# プロンプト表示時の処理（コマンドの結果を記録）
function log_prompt() {
    if [[ -f "$LOG_ENABLED_FILE" ]]; then
        local log_file="${LOG_DIR}/commands_$(date +%Y%m%d).log"
        local exit_code=$?

        if [[ -n "$LOGGING_LAST_COMMAND" ]]; then
            {
                echo "Exit Code: $exit_code"
                echo "===== End of Command ====="
                echo ""
            } >>"$log_file"
        fi

        export LOGGING_LAST_COMMAND="$BASH_COMMAND"
    fi
}

# ログファイルの表示
function log_view() {
    local date_pattern="${1:-$(date +%Y%m%d)}"
    local log_file="${LOG_DIR}/commands_${date_pattern}.log"

    if [[ -f "$log_file" ]]; then
        less "$log_file"
    else
        echo "ログファイルが見つかりません: $log_file"
        echo "利用可能なログファイル:"
        ls -la "${LOG_DIR}"/commands_*.log 2>/dev/null | tail -10
    fi
}

# ログの検索
function log_search() {
    local pattern="$1"

    if [[ -z "$pattern" ]]; then
        echo "使い方: log_search <検索パターン>"
        return 1
    fi

    echo "検索中: '$pattern' in $LOG_DIR"
    grep -n -i --color=auto "$pattern" "${LOG_DIR}"/commands_*.log 2>/dev/null | less -R
}

# 古いログファイルの削除（30日以上）
function log_cleanup() {
    local days="${1:-30}"
    echo "削除対象: $days 日以上前のログファイル"

    find "$LOG_DIR" -name "*.log" -type f -mtime +$days -print

    read -p "これらのファイルを削除しますか? (y/N): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        find "$LOG_DIR" -name "*.log" -type f -mtime +$days -delete
        echo "削除完了"
    else
        echo "キャンセルしました"
    fi
}

# ログファイルの統計情報
function log_stats() {
    echo "=== ログ統計情報 ==="
    echo "ログディレクトリ: $LOG_DIR"
    echo ""

    if [[ -d "$LOG_DIR" ]]; then
        echo "ディスク使用量:"
        du -sh "$LOG_DIR"
        echo ""

        echo "ログファイル数:"
        ls -1 "${LOG_DIR}"/*.log 2>/dev/null | wc -l
        echo ""

        echo "最新のログファイル:"
        ls -lt "${LOG_DIR}"/*.log 2>/dev/null | head -5
    else
        echo "ログディレクトリが存在しません"
    fi
}

# 初期化処理
if [[ -f "$LOG_ENABLED_FILE" ]]; then
    export LOGGING_ENABLED=1
fi

# エイリアスの定義
alias lstart='log_start'
alias lstop='log_stop'
alias lstatus='log_status'
alias lview='log_view'
alias lsearch='log_search'
alias lclean='log_cleanup'
alias lstats='log_stats'

# コマンド実行をログ付きで実行する関数（手動実行用）
function log_exec() {
    if [[ -f "$LOG_ENABLED_FILE" ]]; then
        local log_file="${LOG_DIR}/commands_$(date +%Y%m%d).log"
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

        {
            echo "===== Manual Command Execution ====="
            echo "Time: $timestamp"
            echo "User: $USER"
            echo "Host: $HOSTNAME"
            echo "PWD: $PWD"
            echo "Command: $*"
            echo "----- Output Start -----"
        } >>"$log_file"

        # コマンドを実行し、出力もログに記録
        "$@" 2>&1 | tee -a "$log_file"
        local exit_code=${PIPESTATUS[0]}

        {
            echo "----- Output End -----"
            echo "Exit Code: $exit_code"
            echo "===== End of Manual Execution ====="
            echo ""
        } >>"$log_file"

        return $exit_code
    else
        "$@"
    fi
}

# 完全なセッションログ記録（標準出力・エラー出力も含む）
function log_full_session() {
    if [[ -f "$LOG_ENABLED_FILE" ]]; then
        echo "フルセッションログは既に有効です"
        return
    fi

    local log_file="${LOG_DIR}/full_session_$(date +%Y%m%d_%H%M%S).log"

    touch "$LOG_ENABLED_FILE"
    export LOGGING_ENABLED=1
    export FULL_SESSION_LOGGING=1

    echo "完全セッションログを開始します: $log_file"
    echo "終了するには log_stop を実行してください"
    echo "注意: 完全に停止するには新しいシェルセッションが必要な場合があります"

    # 標準出力と標準エラー出力の両方をログファイルにも送る
    exec > >(tee -a "$log_file")
    exec 2>&1
}

# 追加エイリアス
alias lexec='log_exec'
alias lfull='log_full_session'
