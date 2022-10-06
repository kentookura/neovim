{
  pkgs,
  config,
  lib,
  ...
}:
with lib; {
  options.vim.default = {
    enable = mkEnableOption "Enable default module";
    subOption = mkOption {
      default = true;
      description = "Enable this suboption";
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    vim.luaConfigRC = "";
    vim.startPlugins = with pkgs.neovimPlugins; [
    ];
    vim.globals = {};
    vim.nmap = {};
  };
}
