" 1.basic util(set, number, wrapscan, etc.)
"---------------------------------------
set clipboard+=unnamedplus
set number
set title
set list
set hlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set showcmd
set wrap
set background=dark
set encoding=UTF-8
"---------------------------------------

" 2. color settings TODO(まだいろいろ内容が理解出来てない)
"---------------------------------------
"""""""""""""""""""""""""""""
" ctermxx: console version of vim (guixx is GVim)
" Normal: 通常のテキスト部分
" NonText: eol, extends, precedes
" LineNr: :number と :# コマンドの行番号
" SpecialKey: nbsp, tab, trail
" Folded: 閉じた折り畳みの行
" EndOfBuffer: バッファ外の行(行頭に~が表示されている行)
"""""""""""""""""""""""""""""
"colorscheme evening
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight LineNr ctermfg=gray ctermbg=NONE guifg=#808080 guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
"---------------------------------------

" 1. useful vim key-bindings
"---------------------------------------
" easy escape
inoremap jj <esc>
" easy select(one line)
nnoremap <space><space> <S-v>
" all select
nnoremap <C-c> ggVG
vnoremap <C-c> ggVG
" easy save
nnoremap <Space>ww :w<CR>
nnoremap <Space>wq :wq<CR>
" execute exec.sh in the current file's directory
nnoremap <space>e :!%:p:h/exec.sh<CR>
"---------------------------------------


" 4. fzf
"---------------------------------------
let mapleader = "\<Space>"
" ファイル
nnoremap <silent> <leader>f :Files<CR>
" git ls-filesの結果
nnoremap <silent> <leader>g :GFiles<CR>
" git statusの結果
nnoremap <silent> <leader>G :GFiles?<CR>
" 開いているバッファ TODO
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>
" ag結果
nnoremap <silent> <leader>a :Ag<CR>
" ripgrep結果
"nnoremap <silent> <leader>r :Rg<CR>
"---------------------------------------

