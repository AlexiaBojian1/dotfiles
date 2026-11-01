local gh = function(x) return 'https://github.com/' .. x end

--- Build hooks (must be registered before vim.pack.add so they run on install)
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end
    if name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    elseif name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({
  --- Color theme, icons
  gh 'miikanissi/modus-themes.nvim',
  gh 'NvChad/nvim-colorizer.lua', -- color preview
  gh 'nvim-tree/nvim-web-devicons', -- More Icons
  gh 'ryanoasis/vim-devicons', -- Developer Icons
  gh 'folke/tokyonight.nvim',

  --- Buffer and status/bottom line
  { src = gh 'akinsho/bufferline.nvim', version = vim.version.range('4') }, -- bufferline
  gh 'nvim-lualine/lualine.nvim', -- status line

  --- Telescope (needs `rg` and `fd` installed on the system)
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-lua/plenary.nvim', -- dependency
  gh 'nvim-telescope/telescope-fzf-native.nvim', -- finder
  gh 'nvim-telescope/telescope-file-browser.nvim', -- fileBrowser

  --- Misc
  gh 'lewis6991/gitsigns.nvim', -- git integration
  gh 'kdheepak/lazygit.nvim', --- lazygit integration
  gh 'folke/which-key.nvim', -- which-key, help with mappings
  gh 'tpope/vim-commentary', -- For Commenting gcc
  gh 'sphamba/smear-cursor.nvim', -- smear animation on cursor
  gh 'vuciv/golf', -- golf
  gh 'MunifTanjim/nui.nvim',

  --- Treesitter (master branch: config uses the nvim-treesitter.configs API)
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'master' },

  ---- LSP
  gh 'neovim/nvim-lspconfig', -- Lsp
  gh 'hrsh7th/nvim-cmp', -- Completion
  gh 'hrsh7th/cmp-nvim-lsp', -- plugins
  gh 'hrsh7th/cmp-buffer', -- to go
  gh 'hrsh7th/cmp-path', -- with
  gh 'hrsh7th/cmp-cmdline', -- Lsp
  { src = gh 'mrcjkb/rustaceanvim', version = vim.version.range('9') }, -- rust (replaces rust-tools)
  gh 'rust-lang/rust.vim', --for rust syntax
  gh 'onsails/lspkind.nvim', -- Add pictograms to lsp
  gh 'onsails/diaglist.nvim', -- Live lsp diagnostics in quickfix & loclist

  ---- LSP Installer
  { src = gh 'mason-org/mason.nvim', version = vim.version.range('2') }, -- lsp installer
  { src = gh 'mason-org/mason-lspconfig.nvim', version = vim.version.range('2') },

  ---- Snippets
  gh 'L3MON4D3/LuaSnip',
  gh 'saadparwaiz1/cmp_luasnip',
}, { confirm = false })

require('gitsigns').setup()
require('lualine').setup()
require("colorizer").attach_to_buffer(0, { mode = "background", css = true})
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})
require("luasnip").config.set_config({ -- Setting LuaSnip config
  -- Enable autotriggered snippets
  enable_autosnippets = true,
  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<S-Tab>",
})

require("which-key").add({
    { "<leader>f", group = "file" },
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
})

require('telescope').load_extension('fzf')
require('smear_cursor').setup()
