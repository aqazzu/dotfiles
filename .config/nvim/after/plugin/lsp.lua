local mason = require'mason'
local mason_lspconfig = require'mason-lspconfig'
local cmp = require'cmp'
local lspconfig = require'lspconfig'

-- mason
mason.setup({})
mason_lspconfig.setup({
	-- available at: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  ensure_installed = {
      "pylsp",
      "ocamllsp",
      "lua_ls",
      "clangd",
      -- TODO: fix marksman
      "marksman",
      "texlab"
  },
})

-- nvim-cmp
cmp.setup({
  sources = cmp.config.sources(
    { { name = 'nvim_lsp' } },
    { { name = 'buffer'} },
    { { name = 'path'} }
  ),
  snippet = {
    expand = function(args)
        vim.snippet.expand(args.body)
    end,
  },

  completion = { completeopt = "menu,menuone,preview,noselect",
                 autocomplete = false
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        else
            fallback()
        end
    end, { 'i', 'c' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        else
            fallback()
        end
    end, { 'i', 'c' }),
  }),
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        { { name = 'path' } },
        { { name = 'cmdline' } }
    ),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- lspconfig
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.pylsp.setup { capabilities = capabilities }
lspconfig.ocamllsp.setup { capabilities = capabilities }
lspconfig.lua_ls.setup { capabilities = capabilities }
lspconfig.clangd.setup { capabilities = capabilities }
lspconfig.marksman.setup { capabilities = capabilities }
lspconfig.texlab.setup {
    capabilities = capabilities,
    settings = {
        texlab = {
            bibtexFormatter = "texlab",
            build = {
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f", "-pv" },
                executable = "latexmk",
                forwardSearchAfter = true,
                onSave = true
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" }
            },
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false
            }
        }
    }
}
