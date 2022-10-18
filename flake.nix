{
  description = "Kento's Neovim config";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;

    lsp-signature.url = "github:ray-x/lsp_signature.nvim";
    lsp-signature.flake = false;

    rnix-lsp.url = github:nix-community/rnix-lsp;

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

  outputs = {
    self,
    nixpkgs,
    neovim,
    rnix-lsp,
    vim-unison,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    plugins = [
      "plenary-nvim"
      "telescope-nvim"
      "nvim-treesitter-refactor"
      "nvim-treesitter-textobjects"
      "indent-blankline-nvim"
      "lsp-colors-nvim"
      "trouble"
      "nvim-web-devicons"
      "mason-nvim"
      "mason-lspconfig"
      "vim-markdown"
      "blamer-nvim"
      "vim-unison"
      "calendar-vim"
      "purescript-vim"
      "himalaya"
      "vim-surround"
      "goyo"
      "everforest"
      "yuck-vim"
      "ultisnips"
      "limelight"
      "nvim-tree-lua"
      "nvim-treesitter"
      "nvim-treesitter-context"
      "nvim-lightbulb"
      "fixcursorhold"
      "coq-nvim"
      "coq-artifacts"
      "nvim-lspconfig"
      "completion-nvim"
      "vim-nix"
      "vimtex"
      "neomake"
      "neoformat"
      "nvim-dap"
      "telescope-dap"
      "nvim-dap-virtual-text"
      "lightline-vim"
      "vim-pandoc"
      "vim-pandoc-syntax"
      "vimwiki"
      "nvim-which-key"
      "zen-mode"
    ];
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
      overlays = [];
    };

    externalBitsOverlay = top: last: {
      rnix-lsp = rnix-lsp.defaultPackage.${top.system};
      neovim-nightly = neovim.defaultPackage.${top.system};
    };

    pluginOverlay = top: last: let
      buildPlug = name:
        top.vimUtils.buildVimPluginFrom2Nix {
          pname = name;
          version = "master";
          src = builtins.getAttr name inputs;
        };
      vim-unison = vim-unison.packages."x86_64-linux".vim-unison;
    in {
      neovimPlugins = builtins.listToAttrs (map
        (name: {
          inherit name;
          value = buildPlug name;
        })
        plugins);
    };

    allPkgs = lib.mkPkgs {
      inherit nixpkgs;
      cfg = {};
      overlays = [pluginOverlay externalBitsOverlay];
    };

    lib = import ./lib;

    mkNeoVimPkg = pkgs:
      lib.neovimBuilder {
        inherit pkgs;
        config.vim = {
          viAlias = true;
          vimAlias = true;
          configRC = builtins.readFile ./init.vim;
          globals = {
            lasttab = 1;
            AutoPairsMapCh = 0;
          };
          startPlugins = with pkgs.neovimPlugins;
          with pkgs.vimPlugins; [
            mason-nvim
            mason-lspconfig
            vim-hexokinase
            calendar-vim
            vim-markdown
          ];
          nnoremap = {"<leader><leader>" = "za";};
          vnoremap = {
            "<C-y>" = ":'<,'>w !xclip -selection clipboard<Cr><Cr>";
          };

          disableArrows = true;
          syntaxHighlighting = true;
          lineNumberMode = "relNumber";

          zen.enable = true;
          git.enable = true;

          editor.indentGuide = true;
          editor.mail = true;
          editor.autoFormat = true;
          editor.colorPreview = true;
          editor.trouble = true;

          filetree.enable = true;
          filetree.hideFiles = [".git"];
          filetree.hideIgnoredGitFiles = true;

          theme.defaultTheme = "everforest";
          #theme.light = ["markdown" "latex"];
          theme.goyo.enable = true;
          theme.limelight.enable = true;
          theme.lightline.enable = true;
          theme.lightline.theme = "everforest";

          treesitter.enable = true;
          purescript.enable = true;
          haskell.enable = true;
          unison.enable = true;

          latex.enable = true;
          latex.compiler.method = "latexmk";
          latex.viewer.enable = true;
          latex.viewer.method = "zathura";
          latex.quickfix.enable = true;
          latex.quickfix.autoOpen = false;

          lsp.enable = true;
          lsp.bash = true;
          lsp.nix = true;
          lsp.vimscript = true;
          lsp.tex = true;
          lsp.lightbulb = true;
          lsp.coq = true;
        };
      };
    neovimBuilder = lib.neovimBuilder;
  in rec {
    packages."x86_64-darwin" = with pkgs; rec {
      default = neovim;
      neovim = mkNeoVimPkg allPkgs."x86_64-darwin";
    };
    packages."x86_64-linux" = with pkgs; rec {
      default = neovim;
      neovim = mkNeoVimPkg allPkgs."x86_64-linux";
    };

    nixosModules.default = with lib; let
      cfg = config.neovim;
    in {
      options = {};
      config = {
        environment.systemPackages = with pkgs; [
          rnix-lsp
          ormolu
          nodePackages.prettier
          haskell-language-server
          hlint
          ripgrep
          nodePackages.typescript-language-server
          nodePackages.vim-language-server
          nodePackages.bash-language-server
          nodePackages.yaml-language-server
          nodePackages.purescript-language-server
          texlab
          sumneko-lua-language-server
          ripgrep
        ];
      };
    };

    devShells.${system}.default = import ./shell.nix {inherit pkgs;};
    templates.default = {
      path = ./templates/modules;
      description = "Add a new Neovim module.";
    };

    #apps."x86_64-linux".default = rec {
    #  default = {
    #    type = "app";
    #    program = "${packages."x86_64-linux".default}/bin/nvim";
    #  };
    #};
    #apps."x86_64-darwin".default = rec {
    #  default = {
    #    type = "app";
    #    program = "${packages."x86_64-darwin".default}/bin/nvim";
    #  };
    #};
  };
}
