source ~/.vimrc
nnoremap <space>v :wa \| source ~/.config/nvim/init.vim<cr>

" furomuda book TODO
"---------------------------------------
" inoremap 学習 [学習]
" inoremap 勉強 [勉強]
" inoremap テスト [テスト]
" inoremap fb [FB]
" inoremap 効率 [学習効率]
" inoremap 間隔 [間隔]
" inoremap 思い出し [思い出し]
"cat first_memo.md | sed -e 's/$/  /g' > output.txt
"---------------------------------------

" dein scripts
"---------------------------------------
" TODO(dein自体の自動インストールは未対応)

if &compatible "(&を付けるとsetで設定するvimのオプションにアクセス出来る)
  set nocompatible " Be iMproved(vi互換の動作を無効にする, nvimならいらないらしい?)
endif

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:deindir = s:cache_home . "/dein"
let s:dein_repo_dir = s:deindir . '/repos/github.com/Shougo/dein.vim'
" Required:
" Add the dein installation directory into runtimepath
let &runtimepath = s:dein_repo_dir . "," . &runtimepath
" fnamemodify
" :hで`init.vim`がある`~/.config/nvim/`が指定される.
" その中のtomlディレクトリに保存していく
let s:toml_dir = fnamemodify(expand('<sfile>'), ':h') . "/toml"

" プラグイン読み込み&キャッシュ作成
if dein#min#load_state(s:deindir) " return 1 when cache script is old/invalid/not_found
  " Required:
  " dein#load_tomlのためにtomlファイルまで指定
  " =>dein#begin は第2引数にTOMLパスを指定しなくても良くなったらしい
  call dein#begin(s:deindir) " path to plugin base path directory
  " 起動時に読み込むプラグイン群
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  " 遅延読み込みするプラグイン群
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})
  " Required:
  call dein#end()
  call dein#save_state()
endif


" Let dein manage dein
" path to dein.vim directory
"call dein#add({})
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" Required:
"call dein#end()

" Required:
" これだけで(1)detection(検出)(2)plugin(3)indent全てonに
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if has("vim_starting") && dein#check_install()
 call dein#install()
endif
"---------------------------------------
" dein scripts ends
