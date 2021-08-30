set clipboard=unnamedplus
set number
set title
"set list
set hlsearch
set tabstop=4
set shiftwidth=4
set noexpandtab
set showcmd
set wrap

filetype plugin indent on
syntax on
colorscheme evening
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none 

inoremap jj <esc>

" easy save
nnoremap <Space>ww :w<CR>
nnoremap <Space>wq :wq<CR>

" execute(tmp version) => TODO filetypeについてしらべろ
"nnoremap <space>e :wa \| !echo -e '\e[38;5;0m\e[48;5;51m --- exec ---  \e[m';./exec.sh<cr>
nnoremap <space>e :wa \| term ./exec.sh<cr>

" adjust indent
nnoremap <buffer> == ^v$hyddko<c-r>0<esc>

" easily make debug(for python)
nnoremap <space>d ^d$aprint("<c-r>"", <c-r>")  # debug

" all select
nnoremap <C-c> ggVG
vnoremap <C-c> ggVG

" comment-out/in all debugs
cnoremap co^ g:^\s\+[^#]\+# debug:normal I#
cnoremap ci^ g:^\s\+#.\+# debug:normal ^x

" daily necessities
inoremap tt^ True
inoremap ff^ False
inoremap nn^ None
inoremap to^ <space>#TODO
" daily necessities(for Python)
inoremap 2^ """<esc>}i"""
inoremap `^ ```<CR>```
inoremap fo^ for i in range():
" TODO
inoremap int int()
inoremap len len()
inoremap str str()
inoremap re^ readline()<esc>^h
inoremap rep^ readline()<esc>^hi=<esc>hhi
inoremap map^ map_readline()<esc>^h
inoremap mapp^ map_readline()<esc>^hi=<esc>hhi

augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

"idea
"日本語と英語を切り替えるキーを作る(OSに任せるべきか？)
"前開いてた行数で開くこと(.viminfoを使う？)
