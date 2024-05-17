" 1. keyword shortcut
"---------------------------------------
inoremap tt^ True
inoremap ff^ False
inoremap nn^ None
ab ret return
inoremap se^ self.
" TODO 未整理
"inoremap rt^ return<space>
"inoremap len len()
"inoremap str str()
"inoremap list list()
"---------------------------------------

" 2. syntax shortcut
"---------------------------------------
inoremap fo^ for i in :
inoremap for^ for i in range():
inoremap foz^ for i in zip():
inoremap enu^ enumerate(<esc>f:ha)<esc>
"---------------------------------------

" 3. daily useful
"---------------------------------------
" easily make debug(for python)
nnoremap <space>d ^d$aprint("<c-r>"", <c-r>")  # debug
" comment out by enclosing the top and bottom with three double quotation marks
"inoremap 2^ <esc>}o<esc><C-o>i"""<esc>}i"""<esc>
inoremap 2^ <esc>}o<esc><C-o>i"""<esc>^v$hyddko<c-r>0<esc>}i"""<esc>^v$hyddko<c-r>0<esc>
" debug commnet out
nnoremap 2^ :g/# debug/s/^/#/<CR>
"---------------------------------------
