" メモ, 実験用vimscript
"if has("vim_starting") && has("nvim")
"	echo "aruyo"
"endif
let g:toml_file = fnamemodify(expand('<sfile>'), ':h')
echo g:toml_file
let g:hoge = fnamemodify(expand('<sfile>'), ':p')
