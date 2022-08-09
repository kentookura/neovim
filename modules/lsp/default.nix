{ pkgs, config, lib, ...}:
with lib;
with builtins;

let
  cfg = config.vim.lsp;

  debugpy = pkgs.python3.withPackages (pyPkg: with pyPkg; [ debugpy ]);
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
      (if cfg.lightbulb then nvim-lightbulb else null)
      (if cfg.lightbulb then fixcursorhold else null)
      nvim-lightbulb
      fixcursorhold
      nvim-dap
      nvim-lspconfig 
      (if cfg.coq then coq-nvim else null)
      (if cfg.coq then coq-artifacts else null)
#      vim-nix
#      vimtex
#      (if cfg.nix then vim-nix else null)
#      nvim-treesitter
#      nvim-treesitter-context
    ];

    vim.configRC = ''
    '';

    vim.nnoremap = {
    };

    vim.globals = {
    };

    vim.luaConfigRC = ''
    ${if cfg.coq then ''
    vim.g.coq_settings = {
      xdg = true
    } 
    '' else ""}
      ${if cfg.bash then "" else ""}

      ${if cfg.nix then "" else ""}

      ${if cfg.vimscript then "" else ""}

      ${if cfg.lightbulb then ''
        require('nvim-lightbulb').setup({
          sign = {
            enabled = true,
            priority = 10,
          },
          status_text ={
            enabled = true,
          },
        })
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]
      '' else ""}

      ${if cfg.tex then ''
      require'lspconfig'.texlab.setup({
      cmd = { "texlab" },
      settings = {
        texlab = {
          chktex = {
            onEdit = false,
            onOpenAndSave = false},
          },
        },
      })
      '' else ""} 
      '';
  };
}
