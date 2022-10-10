{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.vim.unison;
in {
  options.vim.unison = {
    enable = mkEnableOption "Enable unison support";
  };

  config = mkIf (cfg.enable) {
    vim.startPlugins = with pkgs.vimPlugins;
    with pkgs.neovimPlugins; [
      vim-unison
    ];
    vim.globals = {};
    vim.nmap = {};
  };
}
