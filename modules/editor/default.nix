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
      telescope = mkOption {
        description = "Enable telescope";
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
      which-key = mkOption {
        description = "Enable which-key";
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
      "<leader>dd" = ":TroubleToggle document_diagnostics<CR>";
      "<leader>wc" = "<cmd>close<cr>";
      "<leader>ws" = "<cmd>split<cr>";
      "<leader>wv" = "<cmd>vsplit<cr>";
      "<C-f>" = ":Files<CR>";
      "<C-b>" = ":Buffers<CR>";
      "<C-g>" = ":Rg<CR>";
    };

    vim.startPlugins = with pkgs.neovimPlugins; [
      indent-blankline-nvim
      plenary-nvim
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
        if cfg.editor.telescope
        then telescope-nvim
        else null
      )
      nvim-which-key
      vim-nix
    ];

    vim.luaConfigRC = ''
      vim.opt.termguicolors = true
      vim.opt.list = true
      ${
        if cfg.editor.telescope
        then builtins.readFile ./telescope.lua
        else ""
      }

      ${
        if cfg.editor.indentGuide
        then builtins.readFile ./indent.lua
        else ""
      }
      ${
        if cfg.editor.trouble
        then builtins.readFile ./trouble.lua
        else ""
      }
      ${
        if cfg.editor.which-key
        then builtins.readFile ./which-key.lua
        else ""
      }

    '';

    vim.configRC = ''
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
    '';
  };
}
