{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.latex;
  mkIfNotNone = val:
    if val == "none"
    then null
    else val;
  mkVimBool = val:
    if val == "1"
    then null
    else "0";
in {
  options.vim.latex = {
    enable = mkEnableOption "Enable latex support";
    compiler = {
      enable = mkEnableOption "Enable compilation";
      method = mkOption {
        default = "latexmk";
        description = "compiler method used by vimtex";
        type = types.enum ["latexmk" "latexrun" "tectonic" "arara" "generic"];
      };
    };
    toc = {
      enable = mkEnableOption "Enable Table of Contents";
      layers = mkOption {
        type = types.attrs;
      };
    };
    viewer = {
      enable = mkEnableOption "Enable pdf viewing";
      method = mkOption {
        default = "zathura";
        description = "viewer method used by vimtex";
        type = types.enum [
          "evince"
          "mupdf"
          "okular"
          "qpdfview"
          "sioyek"
          "skim"
          "sumatraPDF"
          "zathura"
        ];
      };
      searchOnStart = mkOption {
        default = false;
        type = types.bool;
      };
      options = mkOption {
        type = types.str;
      };
    };
    quickfix = {
      enable = mkEnableOption "enable quickfix";
      autoOpen = mkOption {
        description = "Automatically open quickfix window";
        default = false;
        type = types.bool;
      };
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      vimtex
    ];
    vim.globals = {
      "vimtex_compiler_method" = mkIfNotNone cfg.compiler.method;
      "vimtex_view_enabled" = 1;
      "vimtex_view_method" = mkIfNotNone cfg.viewer.method;
      #"vimtex_view_automatic" = 1;
      #"vimtex_view_forward_search_on_start" = 1;
      #"vimtex_view_zathura_options" = "-d out -reuse-instance -forward-search @tex @line @pdf";
      "vimtex_syntax_enabled" = 1;
      "vimtex_quickfix_enabled" = mkVimBool cfg.quickfix.enable;
      "vimtex_quickfix_mode" = mkVimBool cfg.quickfix.autoOpen;
    };
    vim.nmap = {
      "<leader>v" = "<plug>(vimtex-view)";
      "<leader>l" = "<plug>(vimtex-compile)";
      "<leader>e" = "<Plug>(vimtex-errors)";
      "<C-t>" = "<plug>(vimtex-toc-toggle)";
    };

    vim.configRC = builtins.readFile ./latex.vim;
  };
}
