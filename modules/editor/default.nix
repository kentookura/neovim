{ pkgs, config, lib, ...}:
with lib;
with builtins;

let
  cfg = config.vim.editor;
in {
  options.vim.editor = {
    indentGuide = mkEnableOption "Enable indent guides";
    underlineCurrentWord = mkEnableOption "Underline the word under the cursor";

   
    colourPreview = mkOption {
      description = "Enable colour previews";
      type = types.bool;
      default = true;
    };

  };

  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [ 
      #(if cfg.indentGuide then indent-blankline-nvim else null)
      #(if  to run make hexokinase in the plugin folder
      nvim-which-key
      vim-nix
    ];

    vim.nnoremap = {
     "<leader>wc" = "<cmd>close<cr>";
     "<leader>wh" = "<cmd>split<cr>";
     "<leader>wv" = "<cmd>vsplit<cr>";
    };

    vim.luaConfigRC = ''
      local wk = require("which-key")

      wk.register({
        w = {
          name = "window",
          c = { "Close Window"},
          h = { "Split Horizontal" },
          v = { "Split Vertical" },
        },
      }, { prefix = "<leader>" })
     
    '';

    vim.configRC = ''
      ${if cfg.indentGuide then ''
        let g:indentLine_enabled = 1
        set list lcs=tab:\|\ 
      '' else ""}
    '';

  };
}
