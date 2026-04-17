#!/usr/bin/bash
readonly CONFDIR=${PWD}

# コマンドラインオプションを解析
INTERACTIVE=true

while [[ $# -gt 0 ]]; do
  case $1 in
  -y | --yes)
    INTERACTIVE=false
    shift
    ;;
  -h | --help)
    echo "使用法: $0 [オプション]"
    echo "オプション:"
    echo "  -y, --yes       すべての質問に'yes'で回答"
    echo "  -h, --help      このヘルプメッセージを表示"
    exit 0
    ;;
  *)
    echo "不明なオプション: $1"
    exit 1
    ;;
  esac
done

# ユーザーに確認を求める関数
ask_user() {
  local prompt=$1
  local default=${2:-"n"}

  if [ "$INTERACTIVE" = false ]; then
    return 0
  fi

  while true; do
    read -p "$prompt (y/n) [default: $default]: " response
    response=${response:-$default}
    case $response in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) echo "yesまたはnoで答えてください。" ;;
    esac
  done
}

# インテリジェントにシンボリックリンクを作成する関数
create_symlink() {
  local source=$1
  local target=$2

  # ターゲットの親ディレクトリが存在しない場合は作成
  local target_dir=$(dirname "$target")
  if [ ! -d "$target_dir" ]; then
    mkdir -p "$target_dir"
    echo "📁 ディレクトリを作成しました: $target_dir"
  fi

  if [ -L "$target" ]; then
    local current_link=$(readlink "$target")
    if [ "$current_link" = "$source" ]; then
      echo "✓ シンボリックリンクは既に正しく設定されています: $target -> $source"
      return 0
    else
      echo ""
      echo "⚠️  異なるシンボリックリンクが存在します: $target"
      echo "   現在のリンク先: $current_link"
      echo "   新しいリンク先: $source"
      echo ""

      if ask_user "シンボリックリンクを貼り直しますか？"; then
        rm "$target"
        ln -s "$source" "$target"
        echo "✓ シンボリックリンクを貼り直しました: $target -> $source"
      else
        echo "⏭️  スキップしました: $target"
      fi
    fi
    return 0
  fi

  if [ -e "$target" ]; then
    # ソースファイルが存在するかチェック
    if [ ! -e "$source" ]; then
      echo "✗ ソースファイルが存在しません: $source"
      return 1
    fi

    # ファイル内容を比較
    if diff -q "$source" "$target" >/dev/null 2>&1; then
      echo "📁 ファイルの内容が同一です。既存ファイルを移動してシンボリックリンクを作成: $target"
      # タイムスタンプ付きでバックアップを作成
      local backup_name="${target}.backup.$(date +%Y%m%d_%H%M%S)"
      mv "$target" "$backup_name"
      ln -s "$source" "$target"
      echo "✓ シンボリックリンクを作成しました: $target -> $source"
      echo "  (元のファイルをバックアップ: $backup_name)"
    else
      echo ""
      echo "⚠️  異なる内容のファイルが存在します: $target"
      echo "   ソース: $source"
      echo "   ターゲット: $target"

      # 差分を自動表示
      echo ""
      echo "--- 差分 ---"
      diff "$source" "$target" || true
      echo "--- 差分終了 ---"
      echo ""

      if ask_user "シンボリックリンクに置き換えますか？"; then
        local backup_name="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$target" "$backup_name"
        ln -s "$source" "$target"
        echo "✓ シンボリックリンクを作成しました: $target -> $source"
        echo "  (元のファイルをバックアップ: $backup_name)"
      else
        echo "⏭️  スキップしました: $target"
      fi
    fi
  else
    ln -s "$source" "$target"
    echo "✓ シンボリックリンクを作成しました: $target -> $source"
  fi
}

# 必要なパッケージをインストール
<<<<<<< Updated upstream
REQUIRED_PKGS=(curl nasm build-essential tig)
=======
REQUIRED_PKGS=(curl nasm build-essential tig git xclip bat jq zathura unzip)
>>>>>>> Stashed changes
MISSING_PKGS=()
for pkg in "${REQUIRED_PKGS[@]}"; do
  if ! dpkg -s "$pkg" >/dev/null 2>&1; then
    MISSING_PKGS+=("$pkg")
  fi
done

if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
  echo "不足しているパッケージをインストールします: ${MISSING_PKGS[*]}"
  sudo apt update
  sudo apt install -y "${MISSING_PKGS[@]}"
fi

# 必要なディレクトリを作成
mkdir -p ${HOME}/.config

# シンボリックリンクを作成
create_symlink ${CONFDIR}/bash/.bashrc ${HOME}/.bashrc
create_symlink ${CONFDIR}/bash/.bash_profile ${HOME}/.bash_profile
create_symlink ${CONFDIR}/tmux/_.tmux.conf ${HOME}/.tmux.conf
create_symlink ${CONFDIR}/vim/.vimrc ${HOME}/.vimrc
create_symlink ${CONFDIR}/tig/_.tigrc ${HOME}/.tigrc
create_symlink ${CONFDIR}/_.gitconfig ${HOME}/.gitconfig

# .configディレクトリ内の設定
create_symlink ${CONFDIR}/_.config/mise ${HOME}/.config/mise
create_symlink ${CONFDIR}/_.config/git ${HOME}/.config/git
create_symlink ${CONFDIR}/_.config/nvim ${HOME}/.config/nvim
create_symlink ${CONFDIR}/_.config/ghostty ${HOME}/.config/ghostty
create_symlink ${CONFDIR}/_.config/terminator ${HOME}/.config/terminator
create_symlink ${CONFDIR}/_.config/zathura ${HOME}/.config/zathura

# _.claudeディレクトリ内の設定
create_symlink ${CONFDIR}/_.claude/settings.json ${HOME}/.claude/settings.json
create_symlink ${CONFDIR}/_.claude/agents/devcontainer-architect.md ${HOME}/.claude/agents/devcontainer-architect.md
create_symlink ${CONFDIR}/_.claude/hooks/notify.sh ${HOME}/.claude/hooks/notify.sh
create_symlink ${CONFDIR}/_.claude/statusline.py ${HOME}/.claude/statusline.py
