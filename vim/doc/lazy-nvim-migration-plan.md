# dein.vim から lazy.nvim への移行計画

## 概要
このドキュメントは、現在のdein.vimベースのプラグイン管理システムをlazy.nvimに移行するための計画書です。

## 現在のプラグイン構成

### 通常読み込みプラグイン (dein.toml)
1. **dein.vim** - プラグインマネージャー本体
2. **fzf** + **fzf.vim** - ファジーファインダー
3. **defx.nvim** - ファイラー
4. **vim-devicons** + **defx-icons** - アイコン表示
5. **copilot.vim** - GitHub Copilot
6. **vim-wakatime** - コーディング時間計測

### 遅延読み込みプラグイン (dein_lazy.toml)
- 現在は空

### コメントアウトされているプラグイン
- vim-lsp関連（prabirshrestha/vim-lsp、mattn/vim-lsp-settings、asyncomplete.vim、asyncomplete-lsp.vim）
- poet-v
- nerdtree

## 移行手順

### フェーズ1: 準備
1. 現在のプラグイン設定のバックアップ
   ```bash
   cp -r ~/configs/vim/toml ~/configs/vim/toml.bak
   cp ~/configs/vim/init.vim ~/configs/vim/init.vim.bak
   ```

2. deinのキャッシュとプラグインを削除
   ```bash
   rm -rf ~/.cache/dein
   rm -rf ~/.local/share/dein
   ```

### フェーズ2: lazy.nvimのセットアップ
1. lazy.nvimのインストールコードを`init.vim`に追加
2. プラグイン設定用のディレクトリ構造を作成
   ```
   vim/lua/
   ├── config/
   │   └── lazy.lua
   └── plugins/
       ├── core.lua
       ├── ui.lua
       └── coding.lua
   ```

### フェーズ3: プラグイン設定の移行

#### プラグイン移行マッピング

| dein.vim設定 | lazy.nvim設定 |
|-------------|--------------|
| `repo = 'user/plugin'` | `'user/plugin'` または `{ 'user/plugin' }` |
| `build = './install --bin'` | `build = './install --bin'` |
| `merged = '0'` | 削除（lazy.nvimではデフォルト） |
| `depends = 'fzf'` | `dependencies = { 'junegunn/fzf' }` |
| `hook_add = '''...'''` | `config = function() ... end` |
| `on_ft = ['python']` | `ft = { 'python' }` |
| `lazy = 0` | デフォルト（即座に読み込み） |
| `lazy = 1` | `lazy = true` |

#### 具体的な移行例

**dein.toml:**
```toml
[[plugins]]
repo = 'github/copilot.vim'
hook_add = '''
  let g:copilot_enable = 1
'''
```

**lazy.nvim (lua):**
```lua
{
  'github/copilot.vim',
  config = function()
    vim.g.copilot_enable = 1
  end
}
```

### フェーズ4: 設定ファイルの構成

#### 1. init.vim の更新
- dein関連のコードを削除
- lazy.nvimのbootstrap codeを追加
- luaファイルの読み込み設定

#### 2. lua/config/lazy.lua
- lazy.nvimの基本設定
- プラグインディレクトリの指定

#### 3. lua/plugins/*.lua
- カテゴリ別にプラグインを分割
  - core.lua: 基本的なプラグイン（fzf、defx等）
  - ui.lua: UI関連（アイコン、テーマ等）
  - coding.lua: コーディング支援（copilot、LSP等）

### フェーズ5: 動作確認とトラブルシューティング

1. Neovimを起動し、エラーがないか確認
2. `:Lazy`コマンドでプラグイン管理UIを開く
3. 各プラグインが正しくインストールされているか確認
4. 主要な機能（fzf、defx、copilot）の動作確認

### フェーズ6: 最適化

1. 遅延読み込みの設定
   - 使用頻度の低いプラグインに`lazy = true`を設定
   - イベントやファイルタイプに応じた読み込み設定

2. 起動時間の計測と改善
   - `:StartupTime`等で起動時間を確認
   - ボトルネックとなっているプラグインの特定と最適化

## 注意事項

1. **互換性**: VimとNeovimの両方で動作する必要がある場合は、init.vimに条件分岐を残す
2. **バックアップ**: 移行前に必ず現在の設定をバックアップ
3. **段階的移行**: 一度に全て移行せず、基本的なプラグインから順次移行することも可能

## 参考リンク
- [lazy.nvim公式ドキュメント](https://github.com/folke/lazy.nvim)
- [dein.vimからの移行ガイド](https://github.com/folke/lazy.nvim#-migration-guide)
