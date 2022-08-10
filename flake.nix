{
  description = "Kento's Neovim config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rnix-lsp = {url = "github:nix-community/rnix-lsp";};

    goyo = {
      url = "github:junegunn/goyo.vim";
      flake = false;
    };
    everforest = {
      url = "github:sainnhe/everforest";
      flake = false;
    };
    limelight = {
      url = "github:junegunn/limelight.vim";
      flake = false;
    };
    yuck-vim = {
      url = "github:elkowar/yuck.vim";
      flake = false;
    };
    ultisnips = {
      url = "github:SirVer/ultisnips";
      flake = false;
    };
    coq-nvim = {
      url = "github:ms-jpq/coq_nvim";
      flake = false;
    };
    coq-artifacts = {
      url = "github:ms-jpq/coq.artifacts";
      flake = false;
    };
    nvim-tree-lua = {
      url = "github:kyazdani42/nvim-tree.lua";
      flake = false;
    };
    nvim-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };
    nvim-treesitter-context = {
      url = "github:romgrk/nvim-treesitter-context";
      flake = false;
    };
    vim-nix = {
      url = "github:LnL7/vim-nix";
      flake = false;
    };
    vimtex = {
      url = "github:lervag/vimtex";
      flake = false;
    };
    neomake = {
      url = "github:neomake/neomake";
      flake = false;
    };
    nvim-dap = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };
    telescope-dap = {
      url = "github:nvim-telescope/telescope-dap.nvim";
      flake = false;
    };
    nvim-dap-virtual-text = {
      url = "github:theHamsta/nvim-dap-virtual-text";
      flake = false;
    };
    neoformat = {
      url = "github:sbdchd/neoformat";
      flake = false;
    };
    nvim-lightbulb = {
      url = "github:kosayoda/nvim-lightbulb";
      flake = false;
    };
    fixcursorhold = {
      url = "github:antoinemadec/FixCursorHold.nvim";
      flake = false;
    };
    lightline-vim = {
      url = "github:itchyny/lightline.vim";
      flake = false;
    };
    vim-pandoc = {
      url = "github:vim-pandoc/vim-pandoc";
      flake = false;
    };
    vim-pandoc-syntax = {
      url = "github:vim-pandoc/vim-pandoc-syntax";
      flake = false;
    };
    vimwiki = {
      url = "github:vimwiki/vimwiki";
      flake = false;
    };
    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    lightline-gruvbox = {
      url = "github:shinchu/lightline-gruvbox.vim";
      flake = false;
    };
    completion-nvim = {
      url = "github:nvim-lua/completion-nvim";
      flake = false;
    };
    nvim-which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    fzf-vim = {
      url = "github:junegunn/fzf.vim";
      flake = false;
    };
    fzf = {
      url = "github:junegunn/fzf";
      flake = false;
    };
  };
  outputs = {
    self,
    nixpkgs,
    neovim,
    rnix-lsp,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    plugins = [
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
      overlays = [
        inputs.neovim-overlay.overlay
      ];
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
      overlays = [
        pluginOverlay
        externalBitsOverlay
      ];
    };

    lib = import ./lib;

    mkNeoVimPkg = pkgs:
      lib.neovimBuilder {
        inherit pkgs;
        config = {
          vim.viAlias = true;
          vim.vimAlias = true;
          vim.configRC = builtins.readFile ./init.vim;

          vim.editor.indentGuide = true;
          vim.editor.format = true;

          vim.theme.everforest.enable = true;
          vim.theme.everforest.underline = true;
          vim.theme.goyo.enable = true;
          vim.theme.limelight.enable = true;
          vim.theme.lightline.enable = true;

          vim.disableArrows = true;
          vim.syntaxHighlighting = true;
          vim.lineNumberMode = "relNumber";

          vim.latex.enable = true;
          vim.latex.compiler.method = "latexmk";
          vim.latex.viewer.enable = true;
          vim.latex.viewer.method = "zathura";
          vim.latex.viewer.options = "'-reuse-instance -forward-search @tex @line @pdf'";

          vim.lsp.enable = true;
          vim.lsp.bash = true;
          vim.lsp.nix = true;
          vim.lsp.vimscript = true;
          vim.lsp.tex = true;
          vim.lsp.lightbulb = true;
          vim.lsp.coq = true;

          vim.filetree.nvimTreeLua.enable = true;
        };
      };
    neovimBuilder = lib.neovimBuilder;
  in rec {
    apps.default = lib.withDefaultSystems (system: {
      type = "app";
      program = "${self.defaultPackage."${system}"}/bin/nvim";
    });

    defaultPackage = lib.withDefaultSystems (system: self.packages."${system}".neovimKento);

    packages = lib.withDefaultSystems (system: {
      neovimKento = mkNeoVimPkg allPkgs."${system}";
    });
  };
}
