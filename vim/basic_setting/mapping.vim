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

" 3. outer file and application
"---------------------------------------
" easily make HTML template TODO(template.htmlの置き場所再検討)
nnoremap <space>! :read ~/configs/vim/template.html<esc>ggdd
" easily open this file in a chrome browser(%:pの意味などはvim_info.mdを確認)
nnoremap <space>B :silent !google-chrome %:p <CR>
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

" 定義ジャンプ(デフォルトのctagsによるジャンプを上書きしているのでこのあたりは好みが別れます)
nnoremap <C-]> :<C-u>LspDefinition<CR>
"" 定義情報のホバー表示
"nnoremap K :<C-u>LspHover<CR>
"" 名前変更
"nnoremap <LocalLeader>R :<C-u>LspRename<CR>
" 参照検索
nnoremap <LocalLeader>n :<C-u>LspReferences<CR>
"" Lint結果をQuickFixで表示
"nnoremap <LocalLeader>f :<C-u>LspDocumentDiagnostics<CR>
"" テキスト整形
"nnoremap <LocalLeader>s :<C-u>LspDocumentFormat<CR>
"" オムニ補完を利用する場合、定義の追加
"set omnifunc=lsp#complete
