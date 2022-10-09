{
  pkgs,
  config,
  lib,
  ...
}:
with lib; {
  options.vim.haskell = {
    enable = mkEnableOption "Enable latex support";
    lsp = {
      enable = mkEnableOption "Enable compilation";
      method = mkOption {
        default = "haskell-language-server";
        description = "compiler method used by vimtex";
        type = types.enum [];
      };
    };
  };

  config = {
    vim.luaConfigRC = builtins.readFile ./haskell.lua;
    vim.startPlugins = with pkgs.neovimPlugins; [
    ];
    vim.globals = {
    };
    vim.nmap = {
    };
  };
}
