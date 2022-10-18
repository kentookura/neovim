{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.theme;
in {
  imports = [
    ./everforest.nix
    ./goyo.nix
    ./lightline.nix
    ./limelight.nix
  ];
  options.vim.theme = {
    enable = mkEnableOption "enable theme management";
    defaultTheme = mkOption {
      default = "everforest";
      description = "default theme";
      type = types.enum ["everforest" "gruvbox"];
    };
    light = mkOption {
      type = types.list (types.submmodule {
        imports = [
          ./everforest.nix
          {
            config = {
              contrastLight = "medium";
            };
          }
        ];
      });
    };
  };
  #// mkIf (cfg.theme == "gruvbox") {vim.configRC = "colorscheme gruvbox";}
  #// {
  #};
}
