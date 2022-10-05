{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.purescript;
in {
  options.vim.purescript = {
    enable = mkEnableOption "Enable purescript support";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
    ];
    vim.luaConfigRC = builtins.readFile ./purescript.lua;
  };
}
