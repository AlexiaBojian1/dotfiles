------------------------------------------------
-- Mason (LSP installer UI)
------------------------------------------------
require("mason").setup {
  ui = {
    icons = {
      package_installed = "✓",
    },
  },
}

require("mason-lspconfig").setup {}

------------------------------------------------
-- ==== CMP portion (completion) ==== --
------------------------------------------------

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter accepts item
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" }, -- For luasnip users.
  }, {
    { name = "buffer" },
  }),
})

-- gitcommit completion
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" },
  }, {
    { name = "buffer" },
  }),
})

-- cmdline completion for / and ?
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- cmdline completion for :
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

------------------------------------------------
-- LSP core configuration (new API)
------------------------------------------------

-- Capabilities: tell LSP we support nvim-cmp completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Apply capabilities to ALL LSP clients
vim.lsp.config("*", {
  capabilities = capabilities,
})

-- ltex: special config (filetypes + dictionary) - same as your old setup
vim.lsp.config("ltex", {
  filetypes = { "tex", "bib", "markdown", "plaintex" },
  settings = {
    ltex = {
      language = "en-US",
      dictionary = {
        ["en-US"] = {
          "Diego",
          "Rivera",
          "Garrido",
          "simplicial",
          "simplices",
          "isomorphism",
          "homomorphism",
          "homomorphisms",
          "homotopic",
          "Kruskal",
          "surjective",
          "injective",
          "bijective",
          "homomorphism",
          "homotopy",
          "triangulable",
          "triangulations",
          "Triangulations",
          "TODO",
          "monoid",
          "Monoid",
          "submonoid",
          "monoids",
          "submonoids",
          "surjectivity",
          "injectivity",
          "subsemigroup",
          "coset",
          "idempotent",
          "idempotents",
        },
      },
    },
  },
})

-- Enable the servers you care about.
-- Neovim + nvim-lspconfig know the defaults for these.
vim.lsp.enable({
  "clangd",        -- C / C++
  "lua_ls",        -- Lua
  "pylsp",         -- Python
  "rust_analyzer", -- Rust
  "ltex",          -- LaTeX
})

------------------------------------------------
-- LSP completion formatting (icons)
------------------------------------------------

local lspkind = require("lspkind")
cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text", -- show symbol and text
      maxwidth = 50,
      ellipsis_char = "...",
      before = function(entry, vim_item)
        return vim_item
      end,
    }),
  },
})

------------------------------------------------
-- Diagnostics list + appearance
------------------------------------------------

require("diaglist").init({
  debug = false,
  debounce_ms = 150,
})

vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Could be '●', '▎', 'x'
  },
})

