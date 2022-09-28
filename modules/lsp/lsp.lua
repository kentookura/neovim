LaunchHaskellLanguageServer = function()
  local client_id = vim.lsp.start_client({cmd = {"haskell-language-server", "--stdio"}});
  vim.lsp.buf_attach_client(0, client_id)
end

vim.cmd([[
  command! -range LaunchPyright  execute 'lua LaunchPyright()'
]])
