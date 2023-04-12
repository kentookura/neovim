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
  config = let
    #treesitterWithPlugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (
    #  _:
    #    pkgs.tree-sitter.allGrammars
    #);
  in {
    vim.startPlugins = with pkgs.neovimPlugins; [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
    ];
    vim.luaConfigRC = "";
  };
}
