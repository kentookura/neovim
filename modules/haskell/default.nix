{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.vim.haskell;
in {
  options.vim.haskell = {
    enable = mkEnableOption "Enable haskell support";
    lsp = {
      enable = mkEnableOption "Enable LSP";
      method = mkOption {
        default = "haskell-language-server";
        description = "compiler method used by vimtex";
        type = types.enum [];
      };
    };
  };

  config = mkIf (cfg.enable) {
    vim.luaConfigRC = builtins.readFile ./haskell.lua;
    vim.startPlugins = with pkgs.neovimPlugins; [];
    vim.globals = {};
    vim.nmap = {};
  };
}
