{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.lsp;
  debugpy = pkgs.python3.withPackages (pyPkg: with pyPkg; [debugpy]);
in {
  options.vim.lsp = {
    enable = mkEnableOption "Enable lsp support";

    bash = mkEnableOption "Enable Bash Language Support";
    nix = mkEnableOption "Enable NIX Language Support";
    vimscript = mkEnableOption "Enable Vim Script Support";
    tex = mkEnableOption "Enable tex support";

    lightbulb = mkEnableOption "Enable lightbulb";
    coq = mkEnableOption "Enable coq";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      ultisnips
      (
        if cfg.lightbulb
        then nvim-lightbulb
        else null
      )
      (
        if cfg.lightbulb
        then fixcursorhold
        else null
      )
      nvim-lightbulb
      fixcursorhold
      nvim-dap
      nvim-lspconfig
      (
        if cfg.coq
        then coq-nvim
        else null
      )
      (
        if cfg.coq
        then coq-artifacts
        else null
      )
      (
        if cfg.nix
        then vim-nix
        else null
      )
    ];

    vim.configRC = "";

    vim.nnoremap = {
    };

    vim.globals = {
    };

    vim.luaConfigRC =
      builtins.readFile ./coq.lua;
  };
}
