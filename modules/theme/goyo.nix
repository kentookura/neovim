{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.theme;
in {
  options.vim.theme = {
    goyo = {
      enable = mkEnableOption "Enable Goyo";
      goyoHeight = mkOption {
        default = "100%";
      };
    };
  };
  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [goyo];
    vim.configRC = ''
      autocmd! User GoyoEnter Limelight
      autocmd! User GoyoLeave Limelight!
    '';

    vim.nnoremap = {
    };
  };
}
