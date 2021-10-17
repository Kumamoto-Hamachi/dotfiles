" 1. standup setting
"---------------------------------------
set runtimepath+=/home/kumamoto/configs/vim/
runtime! basic_setting/*.vim
autocmd BufNewFile,BufRead *.py runtime! python_setting/*.vim
" これだけで(1)detection(検出)(2)plugin(3)indent全てonに TODO
filetype plugin indent on
syntax on
"---------------------------------------

" 2. event setting
"---------------------------------------
"When opening a file in vim, go to the last place where the cursor was.
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
"---------------------------------------

" 3 TODO
"---------------------------------------
" execute(tmp version) => TODO filetypeについてしらべろ
nnoremap <space>e :wa \| !./exec.sh<cr>
"nnoremap <space>e :wa \| !echo -e '\e[38;5;0m\e[48;5;51m --- exec ---  \e[m';./exec.sh<cr>
"nnoremap <space>e :wa \| term ./exec.sh<cr>

" comment-out/in all debugs
cnoremap co^ g:^\s\+[^#]\+# debug:normal I#
cnoremap ci^ g:^\s\+#.\+# debug:normal ^x
"---------------------------------------
