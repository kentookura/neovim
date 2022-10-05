{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.notes;
in {
  options.vim.notes = {
  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      vim-pandoc
      vim-pandoc-syntax 
    ];
  };
}
