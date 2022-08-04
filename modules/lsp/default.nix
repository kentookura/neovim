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

  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [ 
      nvim-lspconfig 
      completion-nvim 
      nvim-dap
      vim-nix
      vimtex
      (if cfg.nix then vim-nix else null)
      (if cfg.lightbulb then nvim-lightbulb else null)
      #nvim-treesitter
      #nvim-treesitter-context
    ];

    vim.configRC = ''
      " Use <Tab> and <S-Tab> to navigate through popup menu
      inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

      " Set completeopt to have a better completion experience
      set completeopt=menuone,noinsert,noselect

      let g:completion_enable_auto_popup = 2
    '';

    vim.nnoremap = {
      #"<f2>" = "<cmd>lua vim.lsp.buf.rename()<cr>";
      "<leader>cR" = "<cmd>lua vim.lsp.buf.rename()<cr>";
      "<leader>cr" = "<cmd>lua require'telescope.builtin'.lsp_references()<CR>";
      "<leader>ca" = "<cmd>lua require'telescope.builtin'.lsp_code_actions()<CR>";

      "<leader>cd" = "<cmd>lua require'telescope.builtin'.lsp_definitions()<cr>";
      "<leader>ci" = "<cmd>lua require'telescope.builtin'.lsp_implementations()<cr>";
      #"<leader>e" = "<cmd>lua require'telescope.builtin'.lsp_document_diagnostics()<cr>";
      #"<leader>E" = "<cmd>lua require'telescope.builtin'.lsp_workspace_diagnostics()<cr>";
      "<leader>cf" = "<cmd>lua vim.lsp.buf.formatting()<CR>";
      "<leader>ck" = "<cmd>lua vim.lsp.buf.signature_help()<CR>";
      #"<leader>K" = "<cmd>lua vim.lsp.buf.hover()<CR>";

      #"[d" = "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>";
      #"]d" = "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>";

      #"<leader>q" = "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>";

      "<leader>do" = "<cmd>lua require'dap'.step_over()<cr>";
      "<leader>ds" = "<cmd>lua require'dap'.step_into()<cr>";
      "<leader>dO" = "<cmd>lua require'dap'.step_out()<cr>";
      "<leader>dc" = "<cmd>lua require'dap'.continue()<cr>";
      "<leader>db" = "<cmd>lua require'dap'.toggle_breakpoint()<cr>";
      "<leader>dr" = "<cmd>lua require'dap'.repl.open()<cr>";

      #"<leader>d" = "<cmd>Telescope dap commands<cr>";
      #"<leader>B" = "<cmd>Telescope dap list_breakpoints<cr>";
      #"<leader>dv" = "<cmd>Telescope dap variables<cr>";
      #"<leader>df" = "<cmd>Telescope dap frames<cr>";
    };

    vim.globals = {
    };

    vim.luaConfigRC = ''
      local wk = require("which-key")
      wk.register({
        c = {
          name = "Code",
          a = {"Code Action"},
          f = {"Format"},
          d = {"Definitions"},
          i = {"Implementations"},
          R = {"Rename"},
          r = {"References"},
          k = {"Signature"},
        },
        d = {
          name = "Debug",
          o = {"Step Over"},
          s = {"Step Into"},
          O = {"Step Out"},
          c = {"Continue"},
          b = {"Toggle Break Point"},
          r = {"Debug Repl"},

        },
      },{ prefix = "<leader>" })

      local lspconfig = require'lspconfig'
      local dap = require'dap'

      --Tree sitter config
      --require('nvim-treesitter.configs').setup {
      --  highlight = {
      --    enable = true,
      --    disable = {},
      --  },
      --  rainbow = {
      --    enable = true,
      --    extended_mode = true,
      --  },
      --   autotag = {
      --    enable = true,
      --  },
      --  context_commentstring = {
      --    enable = true,
      --  },
      --  incremental_selection = {
      --    enable = true,
      --    keymaps = {
      --      init_selection = "gnn",
      --      node_incremental = "grn",
      --      scope_incremental = "grc",
      --      node_decremental = "grm",
      --    },
      --  },
      --}

      vim.cmd [[set foldmethod=expr]]
      vim.cmd [[set foldlevel=10]]
      vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]

      ${if cfg.lightbulb then ''
        require'nvim-lightbulb'.update_lightbulb {
          sign = {
            enabled = true,
            priority = 10,
          },
          float = {
            enabled = false,
            text = "💡",
            win_opts = {},
          },
          virtual_text = {
            enable = false,
            text = "💡",

          },
          status_text = {
            enabled = false,
            text = "💡",
            text_unavailable = ""           
          }
        }

      '' else ""}

      ${if cfg.bash then ''
        lspconfig.bashls.setup{
          on_attach=require'completion'.on_attach;
          cmd = {"${pkgs.nodePackages.bash-language-server}/bin/bash-language-server", "start"}
        }
      '' else ""}

      ${if cfg.nix then ''
        lspconfig.rnix.setup{
          on_attach=require'completion'.on_attach;
          cmd = {"${pkgs.rnix-lsp}/bin/rnix-lsp"}
        }
      '' else ""}

      ${if cfg.vimscript then ''
        lspconfig.vimls.setup{
          on_attach=require'completion'.on_attach;
          cmd = {'${pkgs.nodePackages.vim-language-server}/bin/vim-language-server', '--stdio' }
        }
      '' else ""}

      ${if cfg.tex then ''
        lspconfig.texlab.setup{
          on_attach=require'completion'.on_attach;
          cmd = {'${pkgs.texlab}/bin/texlab'}
        }
      '' else ""}
    '';
  };
}
