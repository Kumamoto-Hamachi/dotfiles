#!/bin/bash
# シンプルなセッションログ記録機能
# log_full_sessionの機能のみを抽出

# ログディレクトリの設定
export LOG_DIR="${HOME}/logs"
export LOG_ENABLED_FILE="${LOG_DIR}/.session_logging_enabled"

# ログディレクトリの作成
[[ ! -d "$LOG_DIR" ]] && mkdir -p "$LOG_DIR"

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
    export LOG_FILE="$log_file"

    # 元のファイルディスクリプタを保存
    exec 3>&1 # 標準出力を3に保存
    exec 4>&2 # 標準エラー出力を4に保存

    echo "完全セッションログを開始します: $log_file"
    echo "終了するには log_stop を実行してください"

    # 標準出力と標準エラー出力の両方をログファイルにも送る（ANSIエスケープシーケンスを除去）
    # exec > >(tee -a "$log_file")
    exec > >(tee -a >(sed 's/\x1b\[[0-9;]*[a-zA-Z]//g; s/\x1b\[?[0-9]*[hl]//g' >>"$log_file"))
    exec 2>&1
}

# ログ記録の停止
function log_stop() {
    if [[ -n "$FULL_SESSION_LOGGING" ]]; then
        # 標準出力・標準エラー出力を元に戻す
        exec 1>&3 3>&- # 標準出力を元に戻し、3を閉じる
        exec 2>&4 4>&- # 標準エラー出力を元に戻し、4を閉じる
        echo "標準出力・標準エラー出力を元に戻しました"
    fi

    rm -f "$LOG_ENABLED_FILE"
    unset LOGGING_ENABLED
    unset FULL_SESSION_LOGGING
    unset LOG_FILE

    echo "フルセッションログを停止しました"
}

# ログ記録の状態確認
function log_status() {
    if [[ -f "$LOG_ENABLED_FILE" ]]; then
        echo "セッションログ記録: 有効"
        echo "ログディレクトリ: $LOG_DIR"
    else
        echo "セッションログ記録: 無効"
    fi
}

# tmux pipe-pane を使用したセッションログ記録
export TMUX_LOG_ENABLED_FILE="${LOG_DIR}/.tmux_logging_enabled"

function log_tmux_session() {
    if [[ -z "$TMUX" ]]; then
        echo "tmuxセッション内で実行してください"
        return 1
    fi

    if [[ -f "$TMUX_LOG_ENABLED_FILE" ]]; then
        echo "tmuxログは既に有効です"
        return
    fi

    local log_file="${LOG_DIR}/tmux_session_$(date +%Y%m%d_%H%M%S).log"

    touch "$TMUX_LOG_ENABLED_FILE"
    export TMUX_LOGGING_ENABLED=1
    export TMUX_LOG_FILE="$log_file"

    # すべてのペインにpipe-paneを設定（ANSIエスケープシーケンスを除去）
    tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' | while read pane; do
        tmux pipe-pane -t "$pane" "sed 's/\x1b\[[0-9;]*[a-zA-Z]//g; s/\x1b\[?[0-9]*[hl]//g' >> '$log_file'"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ペイン $pane のログ記録を開始" >>"$log_file"
    done

    echo "tmuxセッションログを開始します: $log_file"
    echo "終了するには log_tmux_stop を実行してください"
}

function log_tmux_stop() {
    if [[ -z "$TMUX" ]]; then
        echo "tmuxセッション内で実行してください"
        return 1
    fi

    if [[ ! -f "$TMUX_LOG_ENABLED_FILE" ]]; then
        echo "tmuxログは有効ではありません"
        return
    fi

    # すべてのペインのpipe-paneを停止
    tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}' | while read pane; do
        tmux pipe-pane -t "$pane"
    done

    if [[ -n "$TMUX_LOG_FILE" ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] tmuxログ記録を停止" >>"$TMUX_LOG_FILE"
    fi

    rm -f "$TMUX_LOG_ENABLED_FILE"
    unset TMUX_LOGGING_ENABLED
    unset TMUX_LOG_FILE

    echo "tmuxセッションログを停止しました"
}

function log_tmux_status() {
    if [[ -z "$TMUX" ]]; then
        echo "tmuxセッション内で実行してください"
        return 1
    fi

    if [[ -f "$TMUX_LOG_ENABLED_FILE" ]]; then
        echo "tmuxセッションログ記録: 有効"
        echo "ログファイル: $TMUX_LOG_FILE"
        echo "ログディレクトリ: $LOG_DIR"
    else
        echo "tmuxセッションログ記録: 無効"
    fi
}

# エイリアス
alias lfull='log_full_session'
alias lstop='log_stop'
alias lstatus='log_status'
alias ltmux='log_tmux_session'
alias ltmux_stop='log_tmux_stop'
alias ltmux_status='log_tmux_status'
