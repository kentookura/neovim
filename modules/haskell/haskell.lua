-- Setup lspconfig.
local nvim_lsp = require('lspconfig')
local servers = { 'ltex', 'sumneko_lua' }
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
