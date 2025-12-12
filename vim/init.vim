if exists('g:vscode')
    " VSCode extension
else
    " ordinary Neovim
    nnoremap <space>v :wa \| source ~/.config/nvim/init.vim<cr>
endif
