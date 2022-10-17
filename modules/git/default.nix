{ pkgs
, config
, lib
, ...
}:
with lib;
with builtins; let
  cfg = config.vim;
in
{
  options.vim = {
    git = {
      enable = mkOption {
        description = "Enable git support";
        type = types.bool;
        default = true;
      };
    };
  };

  config = {
    vim.nnoremap = {
    };

    vim.startPlugins = with pkgs.neovimPlugins; [
      (
        if cfg.git.enable
        then blamer-nvim
        else null
      )
    ];

    vim.luaConfigRC = ''
    '';
  };
}
