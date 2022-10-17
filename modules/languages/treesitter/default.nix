{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.treesitter;
in {
  options.vim.treesitter = {
    enable = mkEnableOption "Enable Treesitter support";
  };
  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [
      nvim-treesitter
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
    ];
    #vim.luaConfigRC = builtins.readFile ./treesitter.lua;
  };
}
