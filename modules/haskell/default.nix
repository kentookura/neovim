{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.latex;
  mkIfNotNone = val:
    if val == "none"
    then null
    else val;
  mkVimBool = val:
    if val == "1"
    then null
    else "0";
in {
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

  config = mkIf cfg.enable {
    vim.luaConfigRC = builtins.readFile ./haskell.lua;
    vim.startPlugins = with pkgs.neovimPlugins; [
    ];
    vim.globals = {
    };
    vim.nmap = {
    };
  };
}
