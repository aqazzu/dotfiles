local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

lsp_zero.on_attach(function(client, bufnr)
	-- Keybinds go here
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	-- available at: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  ensure_installed = {"pylsp", "ocamllsp", "lua_ls", "clangd", "ltex"},
  handlers = {
    lsp_zero.default_setup,
  },
})

cmp.setup({
  completion = {
    autocomplete = false
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
  }),
})
