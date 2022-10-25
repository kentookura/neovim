{
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;

    lsp-signature.url = "github:ray-x/lsp_signature.nvim";
    lsp-signature.flake = false;

    rnix-lsp.url = github:nix-community/rnix-lsp;

    nvim-instant.url = github:jbyuki/instant.nvim;
    nvim-instant.flake = false;

    indent-blankline-nvim.url = github:lukas-reineke/indent-blankline.nvim;
    indent-blankline-nvim.flake = false;

    lsp-colors-nvim.url = github:folke/lsp-colors.nvim;
    lsp-colors-nvim.flake = false;

    trouble.url = github:folke/trouble.nvim;
    trouble.flake = false;

    nvim-web-devicons.url = github:kyazdani42/nvim-web-devicons;
    nvim-web-devicons.flake = false;

    zen-mode.url = github:folke/zen-mode.nvim;
    zen-mode.flake = false;

    mason-nvim.url = github:williamboman/mason.nvim;
    mason-nvim.flake = false;

    mason-lspconfig.url = github:williamboman/mason-lspconfig.nvim;
    mason-lspconfig.flake = false;

    neovim.url = github:neovim/neovim?dir=contrib;
    neovim.inputs.nixpkgs.follows = "nixpkgs";

    vim-unison.url = github:ceedubs/unison-nix;

    blamer-nvim.url = github:APZelos/blamer.nvim;
    blamer-nvim.flake = false;

    calendar-vim.url = github:itchyny/calendar.vim;
    calendar-vim.flake = false;

    vim-hexokinase.url = github:RRethy/hexokinase;
    vim-hexokinase.flake = false;

    purescript-vim.url = github:purescript-contrib/purescript-vim;
    purescript-vim.flake = false;

    himalaya.url = github:soywod/himalaya?dir=vim;
    himalaya.flake = false;

    vim-surround.url = github:tpope/vim-surround;
    vim-surround.flake = false;

    goyo.url = github:junegunn/goyo.vim;
    goyo.flake = false;

    everforest.url = github:sainnhe/everforest;
    everforest.flake = false;

    limelight.url = github:junegunn/limelight.vim;
    limelight.flake = false;

    yuck-vim.url = github:elkowar/yuck.vim;
    yuck-vim.flake = false;

    ultisnips.url = github:SirVer/ultisnips;
    ultisnips.flake = false;

    coq-nvim.url = github:ms-jpq/coq_nvim;
    coq-nvim.flake = false;

    coq-artifacts.url = github:ms-jpq/coq.artifacts;
    coq-artifacts.flake = false;

    nvim-tree-lua.url = github:kyazdani42/nvim-tree.lua;
    nvim-tree-lua.flake = false;

    nvim-treesitter.url = github:nvim-treesitter/nvim-treesitter;
    nvim-treesitter.flake = false;

    nvim-treesitter-context.url = github:romgrk/nvim-treesitter-context;
    nvim-treesitter-context.flake = false;

    nvim-treesitter-refactor.url = github:nvim-treesitter/nvim-treesitter-refactor;
    nvim-treesitter-refactor.flake = false;

    nvim-treesitter-textobjects.url = github:nvim-treesitter/nvim-treesitter-textobjects;
    nvim-treesitter-textobjects.flake = false;

    vim-nix.url = github:LnL7/vim-nix;
    vim-nix.flake = false;

    vimtex.url = github:lervag/vimtex;
    vimtex.flake = false;

    neomake.url = github:neomake/neomake;
    neomake.flake = false;

    nvim-dap.url = github:mfussenegger/nvim-dap;
    nvim-dap.flake = false;

    telescope-nvim.url = github:nvim-telescope/telescope.nvim;
    telescope-nvim.flake = false;

    plenary-nvim.url = github:nvim-lua/plenary.nvim;
    plenary-nvim.flake = false;

    telescope-dap.url = github:nvim-telescope/telescope-dap.nvim;
    telescope-dap.flake = false;

    nvim-dap-virtual-text.url = github:theHamsta/nvim-dap-virtual-text;
    nvim-dap-virtual-text.flake = false;

    neoformat.url = github:sbdchd/neoformat;
    neoformat.flake = false;

    nvim-lightbulb.url = github:kosayoda/nvim-lightbulb;
    nvim-lightbulb.flake = false;

    fixcursorhold.url = github:antoinemadec/FixCursorHold.nvim;
    fixcursorhold.flake = false;

    lightline-vim.url = github:itchyny/lightline.vim;
    lightline-vim.flake = false;

    vim-pandoc.url = github:vim-pandoc/vim-pandoc;
    vim-pandoc.flake = false;

    vim-pandoc-syntax.url = github:vim-pandoc/vim-pandoc-syntax;
    vim-pandoc-syntax.flake = false;

    vimwiki.url = github:vimwiki/vimwiki;
    vimwiki.flake = false;

    nvim-lspconfig.url = github:neovim/nvim-lspconfig;
    nvim-lspconfig.flake = false;

    completion-nvim.url = github:nvim-lua/completion-nvim;
    completion-nvim.flake = false;

    nvim-which-key.url = github:folke/which-key.nvim;
    nvim-which-key.flake = false;
  };

