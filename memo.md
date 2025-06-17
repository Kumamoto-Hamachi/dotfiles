● LazyVimベースのNeovim設定の構造は以下の通りです：

  _.config/nvim/
  ├── init.lua            # エントリーポイント（LazyVimのブートストラップ）
  ├── lazy-lock.json      # プラグインのバージョンロック
  ├── lazyvim.json        # LazyVimの設定
  ├── lua/
  │   ├── config/         # 基本設定
  │   │   ├── autocmds.lua   # 自動コマンド
  │   │   ├── keymaps.lua    # キーマッピング
  │   │   ├── lazy.lua       # lazy.nvimの設定
  │   │   └── options.lua    # エディタオプション
  │   └── plugins/        # プラグイン設定
  │       └── example.lua    # プラグイン設定の例
  └── stylua.toml         # Luaコードフォーマッター設定

  主要な役割：
  - init.lua: LazyVimの初期化と~/.vimrcの読み込み
  - config/: Neovimの基本的な動作設定
  - plugins/: 追加プラグインやLazyVimのデフォルト設定の上書き
  - lazy-lock.json: 再現可能な環境のためのプラグインバージョン管理

● インストール済みのプラグイン一覧と機能説明：

  コア・フレームワーク

  1. LazyVim - Neovimの設定フレームワーク。デフォルトのプラグイン構成とキーマップを提供
  2. lazy.nvim - 高速で機能豊富なプラグインマネージャー。遅延読み込みをサポート

  UI/見た目

  3. bufferline.nvim - タブライン表示。開いているバッファをタブのように表示
  4. catppuccin - パステルカラーのモダンなカラースキーム
  5. tokyonight.nvim - 東京の夜をイメージしたダークテーマ（LazyVimのデフォルト）
  6. lualine.nvim - 高速でカスタマイズ可能なステータスライン
  7. mini.icons - ファイルタイプやLSPなどのアイコン表示
  8. noice.nvim - コマンドライン、メッセージ、ポップアップをモダンなUIに置き換え
  9. nui.nvim - Neovim用のUI構築ライブラリ（noice.nvimの依存関係）

  エディタ拡張

  10. flash.nvim - 高速なカーソル移動。文字を入力して画面内の任意の位置にジャンプ
  11. grug-far.nvim - プロジェクト全体の検索と置換機能
  12. mini.ai - 拡張されたテキストオブジェクト（括弧、引用符などの操作を強化）
  13. mini.pairs - 括弧やクォートの自動ペア挿入
  14. which-key.nvim - キーバインドのヘルプ表示。キーを押すと次の候補を表示
  15. persistence.nvim - セッション管理。作業状態の保存と復元

  コード補完・スニペット

  16. blink.cmp - 高速な自動補完エンジン
  17. friendly-snippets - 各種言語用のスニペット集

  構文解析・ハイライト

  18. nvim-treesitter - 高度な構文解析とハイライト。言語理解の基盤
  19. nvim-treesitter-textobjects -
  構文を理解したテキストオブジェクト（関数、クラスなどを選択）
  20. nvim-ts-autotag - HTML/JSXのタグを自動で閉じる
  21. ts-comments.nvim - Treesitterベースのコメント機能

  LSP・フォーマット・リント

  22. nvim-lspconfig - 言語サーバープロトコル（LSP）の設定
  23. mason.nvim - LSPサーバー、DAP、リンター、フォーマッターのインストーラー
  24. mason-lspconfig.nvim - masonとnvim-lspconfigの統合
  25. lazydev.nvim - Lua開発用のLSP設定（Neovim設定開発に特化）
  26. conform.nvim - 高速なコードフォーマッター
  27. nvim-lint - 非同期リンティングフレームワーク

  Git統合

  28. gitsigns.nvim - Git差分の表示、ステージング、ブレイムなどをエディタ内で実行

  診断・デバッグ

  29. trouble.nvim - エラーや警告を見やすく表示する診断リスト
  30. todo-comments.nvim - TODO、FIXME、NOTEなどのコメントをハイライトして管理

  ユーティリティ

  31. plenary.nvim - 多くのプラグインが依存する汎用Luaライブラリ
  32. snacks.nvim - 小さな便利機能の集合（通知、インデント表示など）

  これらのプラグインがLazyVimのデフォルト構成として連携し、モダンなNeovim環境を提供してい
  ます。

> 行番号が相対的に表示されるんだけどこれはなんのプラグインが影響している？

● Task(Find relative line number settings)
  ⎿  Done (13 tool uses · 19.4k tokens · 2m 19.6s)

● 相対行番号はプラグインではなくLazyVimのデフォルト設定によるものです。

  LazyVimは初期設定で以下を有効にしています：
  - number = true - 行番号表示
  - relativenumber = true - 相対行番号表示

  現在のカーソル行は実際の行番号、他の行はカーソルからの距離が表示されます。

  無効にしたい場合は lua/config/options.lua に追加：
  vim.opt.relativenumber = false
