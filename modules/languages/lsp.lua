local configs = require 'lspconfig.configs'
local util = require 'lspconfig.util'
local nvim_lsp = require('lspconfig')
local servers = {
          'texlab',
          'tsserver',
          'lua_ls',
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

nvim_lsp['tsserver'].setup {
  cmd = {
    "$(which typescript-language-server)"
  }
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

nvim_lsp['lua_ls'].setup {
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
