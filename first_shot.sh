#!/usr/bin/bash
#conf_array=(vim bash) #TODO
readonly CONFDIR=${PWD} #TODO ~/configs(これをdotfilesに変えるのはよ)

# コマンドラインオプションを解析
INTERACTIVE=true
FORCE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--force)
            FORCE=true
            shift
            ;;
        -y|--yes)
            INTERACTIVE=false
            shift
            ;;
        -h|--help)
            echo "使用法: $0 [オプション]"
            echo "オプション:"
            echo "  -f, --force     既存ファイルを強制上書き"
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
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "yesまたはnoで答えてください。";;
        esac
    done
}

# インテリジェントにシンボリックリンクを作成する関数
create_symlink() {
    local source=$1
    local target=$2
    
    if [ -L "$target" ]; then
        echo "✓ シンボリックリンクは既に存在します: $target"
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
            
            if ask_user "差分を表示しますか？"; then
                echo "--- 差分 ---"
                diff "$source" "$target" || true
                echo "--- 差分終了 ---"
                echo ""
            fi
            
            if [ "$FORCE" = true ]; then
                echo "🔄 強制モード: 既存ファイルを上書きします"
                local backup_name="${target}.backup.$(date +%Y%m%d_%H%M%S)"
                mv "$target" "$backup_name"
                ln -s "$source" "$target"
                echo "✓ シンボリックリンクを作成しました: $target -> $source"
                echo "  (元のファイルをバックアップ: $backup_name)"
            elif ask_user "シンボリックリンクに置き換えますか？"; then
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

# ディレクトリを作成
mkdir -p ${HOME}/.config/nvim/toml
mkdir -p ${HOME}/.config/mise

# シンボリックリンクを作成
create_symlink ${CONFDIR}/bash/.bashrc ${HOME}/.bashrc
create_symlink ${CONFDIR}/bash/.bash_profile ${HOME}/.bash_profile
create_symlink ${CONFDIR}/tmux/.tmux.conf ${HOME}/.tmux.conf
create_symlink ${CONFDIR}/vim/.vimrc ${HOME}/.vimrc
create_symlink ${CONFDIR}/vim/init.vim ${HOME}/.config/nvim/init.vim
create_symlink ${CONFDIR}/vim/toml/dein.toml ${HOME}/.config/nvim/toml/dein.toml
create_symlink ${CONFDIR}/vim/toml/dein_lazy.toml ${HOME}/.config/nvim/toml/dein_lazy.toml
create_symlink ${CONFDIR}/mise/config.toml ${HOME}/.config/mise/config.toml
