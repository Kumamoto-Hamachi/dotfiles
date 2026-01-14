-- lua/plugins/init.lua
return {
  -- Treesitter (v1.0+ / Neovim 0.11+)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- パーサーを自動インストール
      local parsers = { "python", "lua", "vim", "vimdoc" }
      for _, parser in ipairs(parsers) do
        local ok, _ = pcall(vim.treesitter.language.add, parser)
        if not ok then
          vim.cmd("TSInstall " .. parser)
        end
      end
    end,
  },

  -- Mason (LSPサーバー管理)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright" },
      })
    end,
  },

  -- LSP (Neovim 0.11+ native API)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim", "cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })
      vim.lsp.enable("pyright")
    end,
  },

  -- 補完
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
        },
      })
    end,
  },
  { "hrsh7th/cmp-nvim-lsp" },
}
