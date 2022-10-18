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
      trouble = mkOption {
        description = "Enable trouble diagnostics plugin";
        type = types.bool;
        default = true;
      };
    };
  };

  config = {
    vim.nnoremap = {
      "<leader>d" = ":TroubleToggle<CR>";
      "<leader>wc" = "<cmd>close<cr>";
      "<leader>ws" = "<cmd>split<cr>";
      "<leader>wv" = "<cmd>vsplit<cr>";
      "<C-f>" =        ":Files<CR>";
      "<C-b>" =        ":Buffers<CR>";
      "<C-g>" =        ":Rg<CR>";
    };

    vim.startPlugins = with pkgs.neovimPlugins; [
      indent-blankline-nvim
      (
        if cfg.editor.trouble
        then trouble
        else null
      )
      nvim-web-devicons
      lsp-colors-nvim
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

    vim.luaConfigRC = ''
      vim.opt.termguicolors = true
      vim.opt.list = true
      
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        char_highlight_list = {
        --  "IndentBlanklineIndent1",
        --  "IndentBlanklineIndent2",
        --  "IndentBlanklineIndent3",
        --  "IndentBlanklineIndent4",
        --  "IndentBlanklineIndent5",
        --  "IndentBlanklineIndent6",
        },
      }
      ${
        if cfg.editor.trouble
        then builtins.readFile ./trouble.lua
        else ""
      }
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
