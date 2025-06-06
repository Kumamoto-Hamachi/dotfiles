# Kumamoto's dotfiles

個人的な開発環境設定ファイル（dotfiles）を管理するリポジトリです。

## 概要

Bash、Vim/Neovim、Tmuxの設定ファイルを一元管理し、新しい環境でも素早く開発環境を構築できるようにしています。

## 主な機能

- **Bash設定**: カスタムエイリアス、関数、プロンプト設定
- **Vim/Neovim設定**: dein.vimによるプラグイン管理、言語別設定
- **Tmux設定**: キーバインディング、ステータスバー設定
- **開発ツール統合**: mise、Docker、GitHub CLI、fzf等

## セットアップ

```bash
# リポジトリをクローン
git clone https://github.com/Kumamoto-Hamachi/configs.git ~/configs

# 初期セットアップスクリプトを実行
cd ~/configs
./first_shot.sh
```

### first_shot.shについて

初期セットアップスクリプト`first_shot.sh`は、設定ファイルのシンボリックリンクをインテリジェントに作成します。

**特徴：**
- **冪等性**: 何回実行しても同じ結果
- **スマート処理**: ファイル内容を比較して自動判断
- **安全性**: 全ての既存ファイルをバックアップ
- **対話的**: ユーザーの判断を尊重

**動作パターン：**

1. **シンボリンクが既に存在** → メッセージ表示のみ
2. **ファイルが存在しない** → シンボリンク作成
3. **同じ内容のファイルが存在** → 自動でバックアップ＆シンボリンク作成
4. **異なる内容のファイルが存在** → ユーザーに確認

**オプション：**
```bash
./first_shot.sh           # 通常実行（対話的）
./first_shot.sh -f        # 強制実行（既存ファイルを全て置換）
./first_shot.sh -y        # 全ての質問に「yes」で回答
./first_shot.sh -h        # ヘルプ表示
```

**使用例：**

```bash
# 通常の初回セットアップ
$ ./first_shot.sh
✓ シンボリックリンクを作成しました: /home/user/.bashrc -> /home/user/configs/bash/.bashrc
📁 ファイルの内容が同一です。既存ファイルを移動してシンボリックリンクを作成: /home/user/.vimrc
✓ シンボリックリンクを作成しました: /home/user/.vimrc -> /home/user/configs/vim/.vimrc
  (元のファイルをバックアップ: /home/user/.vimrc.backup.20231207_143022)

⚠️  異なる内容のファイルが存在します: /home/user/.tmux.conf
   ソース: /home/user/configs/tmux/.tmux.conf
   ターゲット: /home/user/.tmux.conf
差分を表示しますか？ (y/n) [default: n]: y
--- 差分 ---
2c2
< set -g prefix C-q
---
> set -g prefix C-b
--- 差分終了 ---

シンボリックリンクに置き換えますか？ (y/n) [default: n]: y
✓ シンボリックリンクを作成しました: /home/user/.tmux.conf -> /home/user/configs/tmux/.tmux.conf
  (元のファイルをバックアップ: /home/user/.tmux.conf.backup.20231207_143025)
```

```bash
# 強制実行（全て置換）
$ ./first_shot.sh -f
🔄 強制モード: 既存ファイルを上書きします
✓ シンボリックリンクを作成しました: /home/user/.bashrc -> /home/user/configs/bash/.bashrc
  (元のファイルをバックアップ: /home/user/.bashrc.backup.20231207_143030)
```

**安全性：**
- 全ての既存ファイルはタイムスタンプ付きでバックアップ
- 同一内容の場合のみ自動処理
- 異なる内容の場合は必ずユーザー確認

**作成されるシンボリンク：**
- `~/.bashrc` → `configs/bash/.bashrc`
- `~/.bash_profile` → `configs/bash/.bash_profile`
- `~/.tmux.conf` → `configs/tmux/.tmux.conf`
- `~/.vimrc` → `configs/vim/.vimrc`
- `~/.config/nvim/init.vim` → `configs/vim/init.vim`
- `~/.config/nvim/toml/dein.toml` → `configs/vim/toml/dein.toml`
- `~/.config/nvim/toml/dein_lazy.toml` → `configs/vim/toml/dein_lazy.toml`
- `~/.config/mise/config.toml` → `configs/mise/config.toml`

## ディレクトリ構成

```
configs/
├── bash/           # Bash関連の設定
│   ├── alias.bash  # エイリアス定義
│   └── functions/  # カスタム関数
├── vim/            # Vim/Neovim設定
│   ├── init.vim    # Neovimメイン設定
│   └── toml/       # プラグイン設定
└── tmux/           # Tmux設定
```

## 主要なエイリアス

- `sb` - .bashrcを再読み込み
- `g` - git
- `d` - docker
- `dc` - docker-compose
- `v` - nvim

## Author

* [Kumamoto](https://github.com/Kumamoto-Hamachi)

## License

This repository is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).
