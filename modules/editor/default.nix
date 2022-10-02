{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim;
in {
  options.vim = {
    editor = {
      indentGuide = mkEnableOption "Enable indent guides";
      underlineCurrentWord = mkEnableOption "Underline the word under the cursor";
      autoFormat = mkEnableOption "Enable autoformat";
      fzf = mkOption {
        description = "Enable fzf";
        type = types.bool;
        default = true;
      };
      colorPreview = mkOption {
        description = "Enable colour previews";
        type = types.bool;
        default = true;
      };
      mail = mkOption {
        description = "Enable Himalaya client";
        type = types.bool;
        default = true;
      };
    };
    unison = {
      enable = mkEnableOption "Enable Unison support";
    };
  };

  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [
      (
        if cfg.unison.enable
        then vim-unison
        else null
      )

      (
        if cfg.editor.mail
        then himalaya
        else null
      )
      (
        if cfg.editor.autoFormat
        then neoformat
        else null
      )
      (
        if cfg.editor.fzf
        then fzf
        else null
      )
      (
        if cfg.editor.fzf
        then fzf-vim
        else null
      )
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

        "${
        if cfg.editor.fzf
        then builtins.readFile ./fzf.vim
        else ""
      }"

        "${
        if cfg.editor.autoFormat
        then ''
          augroup fmt
            autocmd!
            autocmd BufWritePre *  Neoformat
          augroup END
        ''
        else ""
      }

      map <C-f> :Files<CR>
      map <leader>b :Buffers<CR>
      nnoremap <leader>g :Rg<CR>
      nnoremap <leader>G :GGrep<CR>


      ${
        if cfg.editor.indentGuide
        then ''
          let g:indentLine_enabled = 1
          set list lcs=tab:\|\
        ''
        else ""
      }
    '';
  };
}
