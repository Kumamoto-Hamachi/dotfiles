-- init.lua

-- Leaderキーを先に設定（キーマップより前に必要）
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 既存の.vimrc設定を読み込む
vim.cmd('source ~/.vimrc')

--------------------------------------------------------------------------------
-- lazy.nvim ブートストラップ
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグイン設定を読み込む
require("lazy").setup("plugins")

--------------------------------------------------------------------------------
-- VSCode / 通常Neovim の分岐
--------------------------------------------------------------------------------
if vim.g.vscode then
  -- VSCode Neovim拡張専用の設定
else
  -- 通常Neovim専用の設定
  vim.keymap.set('n', '<leader>v', ':wa | source ~/.config/nvim/init.lua<CR>',
    { noremap = true, silent = true, desc = "Save all and reload config" })
end

--------------------------------------------------------------------------------
-- Debug print（<leader>d でカーソル下の単語をデバッグprint文に置換）
--------------------------------------------------------------------------------
local function insert_debug_print()
  local word = vim.fn.expand('<cword>')
  local ext = vim.fn.expand('%:e')
  local replacement

  if ext == 'py' then
    replacement = string.format('print("%s", %s)  # debug', word, word)
  elseif ext == 'tsx' or ext == 'jsx' or ext == 'js' or ext == 'ts' then
    replacement = string.format('console.log("%s", %s)  // debug', word, word)
  else
    vim.notify("No debug print defined for ." .. ext, vim.log.levels.WARN)
    return
  end

  -- 現在行を取得して単語を置換
  local line = vim.api.nvim_get_current_line()
  local new_line = line:gsub(word, replacement, 1)
  vim.api.nvim_set_current_line(new_line)
end

vim.keymap.set('n', '<leader>d', insert_debug_print, { noremap = true, silent = true, desc = "Insert debug print" })
