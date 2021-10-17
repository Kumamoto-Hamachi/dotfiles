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
"---------------------------------------

" 2. daily necessities
"---------------------------------------
inoremap to^ <space>#TODO
" enclose single quotation TODO(マークダウン用の設定集出来たらそこに移す)
inoremap `^ ```<CR>```
" adjust indent TODO(ここが本当にふさわしい置き場所か?python特有では?)
"nnoremap <buffer> == ^v$hyddko<c-r>0<esc> pythonで使うように
nnoremap == ^v$hyddko<c-r>0<esc>
"---------------------------------------
