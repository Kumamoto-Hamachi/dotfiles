#!/usr/bin/env bash
# シンプルなコマンドログ記録機能
#
# 使い方: {command} 2>&1 | log_command "説明文"
# 例:
#   ls -la 2>&1 | log_command "ディレクトリ一覧確認"
#   docker ps 2>&1 | llog "コンテナ状況確認"
#
# ログファイル: ~/logs/command_log_YYYYMMDD.log
# 記録内容: プロンプト情報、gitブランチ、説明、実行コマンド、出力結果

# シンプルなコマンドログ記録関数
function log_command() {
  local description="$1"
  local log_dir="${HOME}/logs"
  local log_file="${log_dir}/command_log_$(date +%Y%m%d).log"

  # ログディレクトリの作成
  [[ ! -d "$log_dir" ]] && mkdir -p "$log_dir"

  # 現在のコマンドプロンプトを記録
  local prompt_info="[$(date '+%Y-%m-%d %H:%M:%S')] $(whoami)@$(hostname):$(pwd)"

  # gitブランチ情報を取得
  local git_info=""
  if git rev-parse --git-dir > /dev/null 2>&1; then
    local branch=$(git branch --show-current 2> /dev/null || git rev-parse --short HEAD 2> /dev/null)
    local git_status=""
    if ! git diff-index --quiet HEAD -- 2> /dev/null; then
      git_status=" (変更あり)"
    fi
    git_info="ブランチ: $branch$git_status"
  fi

  # ログヘッダーをファイルに記録
  {
    echo "=========================================="
    echo "プロンプト: $prompt_info"
    [[ -n "$git_info" ]] && echo "$git_info"
    echo "説明: $description"
    echo "実行コマンド: $(fc -ln -1 | sed 's/^[ \t]*//')"
    echo "実行結果:"
  } >> "$log_file"

  # 標準入力を処理（画面表示は色付き、ログは色なし）
  while IFS= read -r line; do
    echo "$line"                                            # 画面にはそのまま表示（色付き）
    echo "$line" | sed 's/\x1b\[[0-9;]*m//g' >> "$log_file" # ログには色なしで記録
  done

  # ログフッターをファイルに記録
  {
    echo "=========================================="
    echo ""
  } >> "$log_file"
}

# エイリアス
alias llog='log_command'
