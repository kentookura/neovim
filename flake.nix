{
  description = "Kento's Neovim config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    rnix-lsp.url = "github:nix-community/rnix-lsp";

    zenmode.url = github:folke/zen-mode.nvim;
    zenmode.flake = false;

    neovim.url = "github:neovim/neovim?dir=contrib";
    neovim.inputs.nixpkgs.follows = "nixpkgs";

    vim-unison.url = "github:ceedubs/unison-nix";

    blamer-nvim.url = github:APZelos/blamer.nvim;
    blamer-nvim.flake = false;

    calendar-vim.url = "github:itchyny/calendar.vim";
    calendar-vim.flake = false;

    vim-hexokinase.url = "github:RRethy/hexokinase";
    vim-hexokinase.flake = false;

    purescript-vim.url = "github:purescript-contrib/purescript-vim";
    purescript-vim.flake = false;

    himalaya.url = "github:soywod/himalaya?dir=vim";
    himalaya.flake = false;

    vim-surround.url = "github:tpope/vim-surround";
    vim-surround.flake = false;

    goyo.url = "github:junegunn/goyo.vim";
    goyo.flake = false;

    everforest.url = "github:sainnhe/everforest";
    everforest.flake = false;

    limelight.url = "github:junegunn/limelight.vim";
    limelight.flake = false;

    yuck-vim.url = "github:elkowar/yuck.vim";
    yuck-vim.flake = false;

    ultisnips.url = "github:SirVer/ultisnips";
    ultisnips.flake = false;

    coq-nvim.url = "github:ms-jpq/coq_nvim";
    coq-nvim.flake = false;

    coq-artifacts.url = "github:ms-jpq/coq.artifacts";
    coq-artifacts.flake = false;

    nvim-tree-lua.url = "github:kyazdani42/nvim-tree.lua";
    nvim-tree-lua.flake = false;

    nvim-treesitter.url = "github:nvim-treesitter/nvim-treesitter";
    nvim-treesitter.flake = false;

    nvim-treesitter-context.url = "github:romgrk/nvim-treesitter-context";
    nvim-treesitter-context.flake = false;

    vim-nix.url = "github:LnL7/vim-nix";
    vim-nix.flake = false;

    vimtex.url = "github:lervag/vimtex";
    vimtex.flake = false;

    neomake.url = "github:neomake/neomake";
    neomake.flake = false;

    nvim-dap.url = "github:mfussenegger/nvim-dap";
    nvim-dap.flake = false;

    telescope-dap.url = "github:nvim-telescope/telescope-dap.nvim";
    telescope-dap.flake = false;

    nvim-dap-virtual-text.url = "github:theHamsta/nvim-dap-virtual-text";
    nvim-dap-virtual-text.flake = false;

    neoformat.url = "github:sbdchd/neoformat";
    neoformat.flake = false;

    nvim-lightbulb.url = "github:kosayoda/nvim-lightbulb";
    nvim-lightbulb.flake = false;

    fixcursorhold.url = "github:antoinemadec/FixCursorHold.nvim";
    fixcursorhold.flake = false;

    lightline-vim.url = "github:itchyny/lightline.vim";
    lightline-vim.flake = false;

    vim-pandoc.url = "github:vim-pandoc/vim-pandoc";
    vim-pandoc.flake = false;

    vim-pandoc-syntax.url = "github:vim-pandoc/vim-pandoc-syntax";
    vim-pandoc-syntax.flake = false;

    vimwiki.url = "github:vimwiki/vimwiki";
    vimwiki.flake = false;

    nvim-lspconfig.url = "github:neovim/nvim-lspconfig";
    nvim-lspconfig.flake = false;

    lightline-gruvbox.url = "github:shinchu/lightline-gruvbox.vim";
    lightline-gruvbox.flake = false;

    completion-nvim.url = "github:nvim-lua/completion-nvim";
    completion-nvim.flake = false;

    nvim-which-key.url = "github:folke/which-key.nvim";
    nvim-which-key.flake = false;

    fzf-vim.url = "github:junegunn/fzf.vim";
    fzf-vim.flake = false;

    fzf.url = "github:junegunn/fzf";
    fzf.flake = false;
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
      "dkasak-gruvbox"
      "nvim-which-key"
      "fzf"
      "fzf-vim"
    ];
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
      overlays = [];
    };

    packages = with pkgs; {
      latex-language-server = texlab;
      haskell-language-server = haskell-language-server;
      finder = fzf;
    };
    #pstree =
    #pplatex =
    #sumneko-lua-language-server =
    #pulp =
    #silver-searcher =
    #ctags =
    #proselint =
    #purescript-language-server =

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
      neovimPlugins = builtins.listToAttrs (map (name: {
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
          nnoremap = {};
          inoremap = {};
          vnoremap = {};
          xnoremap = {};
          snoremap = {};
          cnoremap = {};
          onoremap = {};
          tnoremap = {};
          nmap = {};
          imap = {};
          vmap = {};
          xmap = {};
          smap = {};
          cmap = {};
          omap = {};
          tmap = {};
          startPlugins = with pkgs.neovimPlugins;
          with pkgs.vimPlugins; [
            vim-hexokinase
            calendar-vim
            blamer-nvim
          ];

          disableArrows = true;
          syntaxHighlighting = true;
          lineNumberMode = "relNumber";

          editor.indentGuide = true;
          editor.autoFormat = true;
          editor.fzf = true;
          editor.colorPreview = true;

          filetree.enable = true;
          filetree.hideFiles = [".git"];
          filetree.hideIgnoredGitFiles = true;

          theme.everforest.enable = true;
          theme.everforest.underline = true;
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
          # Available servers which I might find useful:
          # bashls
          # bufls
          # dhall_lsp_server
          # cssls
          # dockerls
          # eslint
          # marksman
          # ocamlls/ocamllsp
          # purescriptls
          # pyright/pyre/pylsp
          # texlab
        };
      };
    neovimBuilder = lib.neovimBuilder;
  in rec {
    devShells.${system}.default = import ./shell.nix {inherit pkgs;};
    templates.default = {
      path = ./templates/modules;
      description = "Add a new Neovim module.";
    };

    apps.${system} = rec {
      nvim = {
        type = "app";
        program = "${packages.${system}.default}/bin/nvim";
      };
      default = nvim;
    };

    overlays.default = final: prev: {
      inherit neovimBuilder;
      neovim = packages.${system}.neovim;
      neovimPlugins = pkgs.neovimPlugins;
    };

    nixosModules.default = {}: {
      options = {};
      config = {
        packages = with pkgs; [
        ];
      };
    };

    packages.${system} = with pkgs; rec {
      default = neovim;
      neovim = mkNeoVimPkg allPkgs."${system}";
    };
  };
}
