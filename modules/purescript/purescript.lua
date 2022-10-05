
-- Setup lspconfig.
local nvim_lsp = require('lspconfig')
nvim_lsp.purescriptls.setup{
  filetypes = { "purescript" },
  settings = {
    purescript = {
      addSpagoSources = true -- e.g. any purescript language-server config here
    }
  },
  flags = {
    debounce_text_changes = 150,
  }
}
