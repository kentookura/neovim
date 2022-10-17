{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.python
in {
  options.vim.python = {
    enable = mkEnableOption "Enable python support";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
    ];
    vim.luaConfigRC = builtins.readFile ./python.lua;
  };
}
