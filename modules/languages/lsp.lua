local configs = require 'lspconfig.configs'
local util = require 'lspconfig.util'
local nvim_lsp = require('lspconfig')
local servers = {
          'texlab',
          'sumneko_lua',
          'bashls',
          'bufls',
          'dhall_lsp_server',
          'cssls',
          'dockerls',
          'rnix',
          'elmls',
          'unison',
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

nvim_lsp['elmls'].setup {
  cmd = {  "elm-language-server" },
  capabilities = capabilities,
}

nvim_lsp['cssls'].setup {
  cmd = {  "css-languageserver", "--stdio" },
  capabilities = capabilities,
}

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
