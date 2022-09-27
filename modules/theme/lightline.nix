{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.theme.lightline;
in {
  options.vim.theme.lightline = {
    enable = mkEnableOption "Enable lightline";
    theme = mkOption {
      default = "wombat";
      type = types.enum [
        "everforest"
        "wombat"
        "powerline"
        "jellybeans"
        "solarized dark"
        "solarized dark"
        "papercolor dark"
        "papercolor light"
        "seoul256"
        "one dark"
        "one light"
        "landscape"
      ];
    };
  };
  config = mkIf (cfg.enable) (
    let
      lightCfg = {
        "colorscheme" = cfg.theme;
      };
    in {
      vim.startPlugins = with pkgs.neovimPlugins; [lightline-vim];
      vim.globals = {
        "lightline" = lightCfg;
      };
    }
  );
}
