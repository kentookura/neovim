local nvim_lsp = require('lspconfig')
local servers = {
          'texlab',
          'sumneko_lua',
          'bashls',
          'bufls',
          'dhall_lsp_server',
          'cssls',
          'dockerls',
          -- 'marksman',
          -- 'emmet_ls',
          'ocamlls',
          'purescriptls',
          'pyright',
          'texlab',
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
  }
end

nvim_lsp['sumneko_lua'].setup {
  cmd = {  "lua-language-server" },
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
vim.diagnostic.config({
  virtual_text = false,
})
