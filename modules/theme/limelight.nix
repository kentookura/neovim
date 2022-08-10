{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.theme.limelight;
in {
  options.vim.theme.limelight = {
    enable = mkEnableOption "Enable limelight";
  };
  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [limelight];
  };
}
