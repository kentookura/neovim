{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.purescript;
  mkIfNotNone = val:
    if val == "none"
    then null
    else val;
  mkVimBool = val:
    if val == "1"
    then null
    else "0";
in {
  options.vim.purescript = {
    enable = mkEnableOption "Enable purescript support";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      purescript-vim
    ];
    vim.globals = {
    };
    vim.nmap = {
    };
  };
}
