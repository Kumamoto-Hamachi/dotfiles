set runtimepath+=/home/kumamoto/configs/vim/
runtime! /basic_setting/*.vim

" これだけで(1)detection(検出)(2)plugin(3)indent全てonに
filetype plugin indent on
syntax on

"autocmd BufNewFile,BufRead *.py set number



" execute(tmp version) => TODO filetypeについてしらべろ
nnoremap <space>e :wa \| !./exec.sh<cr>
"nnoremap <space>e :wa \| !echo -e '\e[38;5;0m\e[48;5;51m --- exec ---  \e[m';./exec.sh<cr>
"nnoremap <space>e :wa \| term ./exec.sh<cr>

" adjust indent
"nnoremap <buffer> == ^v$hyddko<c-r>0<esc> pythonで使うように
nnoremap == ^v$hyddko<c-r>0<esc>

" easily make debug(for python)
nnoremap <space>d ^d$aprint("<c-r>"", <c-r>")  # debug


" comment-out/in all debugs
cnoremap co^ g:^\s\+[^#]\+# debug:normal I#
cnoremap ci^ g:^\s\+#.\+# debug:normal ^x

" daily necessities
inoremap tt^ True
inoremap ff^ False
inoremap nn^ None
" easily make HTML template
nnoremap <space>! :read ~/.vim/ftplugin/html/template.html<esc>ggdd
" daily necessities(for Python)
"inoremap 2^ <esc>}o<esc><C-o>i"""<esc>}i"""<esc>
inoremap 2^ <esc>}o<esc><C-o>i"""<esc>^v$hyddko<c-r>0<esc>}i"""<esc>^v$hyddko<c-r>0<esc>
inoremap `^ ```<CR>```
inoremap fo^ for i in :
inoremap for^ for i in range():
inoremap foz^ for i in zip():
" TODO
inoremap re^ readline()<esc>^h
inoremap rep^ readline()<esc>^hi=<esc>hhi
inoremap map^ map_readline()<esc>^h
inoremap list^ list_readline()<esc>^
inoremap listp^ list_readline()<esc>^hi=<esc>hhi
inoremap __ __<esc>A__(self):<esc>^2f_a
inoremap se^ self.
inoremap enu^ enumerate(<esc>f:ha)<esc>
" TODO
"inoremap rt^ return<space>
ab ret return
"inoremap len len()
"inoremap str str()
"inoremap list list()

"When opening a file in vim, go to the last place where the cursor was.
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

"idea
"日本語と英語を切り替えるキーを作る(OSに任せるべきか？)
