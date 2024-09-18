local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

-- nvim-lspconfig
local lsp_attach = function(client, bufnr)
	-- Keybinds go here
  lsp_zero.default_keymaps({buffer = bufnr})
end

lsp_zero.extend_lspconfig({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  lsp_attach = lsp_attach,
  float_border = 'rounded',
  sign_text = true,
})

require('mason').setup({})
require('mason-lspconfig').setup({
	-- available at: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  ensure_installed = {"pylsp", "ocamllsp", "lua_ls", "clangd", "ltex", "marksman" },
  handlers = {
    lsp_zero.default_setup,
  },
})

-- nvim-cmp
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
    require('luasnip').lsp_expand(args.body)
  end,
  },
  completion = {
    autocomplete = false
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp_action.tab_complete(),
--    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
  }),
})
