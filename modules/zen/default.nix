{
  pkgs,
  config,
  lib,
  ...
}:
with lib; 
let cfg = config.vim;
in
{
  options.vim.zen = {
    enable = mkEnableOption "Enable Zen mode";
    subOption = mkOption {
      default = true;
      description = "Enable this suboption";
      type = types.bool;
    };
  };

  config = mkIf cfg.zen.enable {
    vim.luaConfigRC = "";
    vim.startPlugins = with pkgs.neovimPlugins; [
      zen-mode
    ];
    vim.globals = {};
    vim.nmap = {};
  };
}
