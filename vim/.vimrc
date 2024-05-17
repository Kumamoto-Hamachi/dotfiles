" 1. standup setting
"---------------------------------------
"set runtimepath+=/home/kumamoto/configs/vim/ setで+=expandは上手く行かないっぽい
let g:vim_conf_dir = expand("~/configs/vim")
let &runtimepath = g:vim_conf_dir . "," . &runtimepath
runtime! basic_setting/*.vim
autocmd BufNewFile,BufRead *.py runtime! python_setting/*.vim
autocmd BufNewFile,BufRead *.js runtime! js_setting/*.vim
autocmd BufNewFile * pu! ='存在しない新しいﾋﾞﾑｩ!!!'
"augroup erase
"  autocmd BufNewFile * put ='ﾋﾞﾑｩｯ'
"augroup END
" これだけで(1)detection(検出)(2)plugin(3)indent全てonに TODO
" deinの関連で書いたのでいらなくなるかも
filetype plugin indent on
syntax on
"TODO うまくいかない(いったんaliasで対応 vi=vi-p)
"let bufsize = bufnr('$')
"if bufsize > 1
"  "tab ball !bprev
"  echo bufsize
"  bufdo tab ba
"endif
"tab ba " 困ったら:taboとかtabcね
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
" guifontを設定しないと文字化けになる。terminalで行ったフォントの設定と同様
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set encoding=utf-8

" フォルダアイコンを表示
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
call webdevicons#refresh()
endif

" tab
cnoremap tb tabe
" 3gt ... move to 3th tab
nnoremap gb gT
" :tabm 3 ... move current tab 3th
" 下2行で閉じたタブを再度開く
autocmd QuitPre * let @r = @%
cabbr tr tabe <c-r>r
nnoremap gf <c-w>gF
nnoremap <c-w>gf yaW:tabe <c-r>"<cr>
"---------------------------------------

