-- Setup lspconfig.
local nvim_lsp = require('lspconfig')
-- haskell
local util = require 'lspconfig.util'
nvim_lsp['hls'].setup{
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  capabilities = capabilities,
  filetypes = { "haskell", "lhaskell" },
  root_dir = function (filepath)
      return (
        util.root_pattern('hie.yaml', 'stack.yaml', 'cabal.project')(filepath)
        or util.root_pattern('*.cabal', 'package.yaml')(filepath)
      )
    end,
  settings = {
    haskell = {
      formattingProvider = "ormolu"
    }
  },
  single_file_support = true
}
