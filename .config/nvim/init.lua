local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim",  dependencies = { "nvim-lua/plenary.nvim" } },
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp",
  "nvim-lualine/lualine.nvim",
  "lewis6991/gitsigns.nvim",
})

vim.opt.number, vim.opt.relativenumber = true, true
