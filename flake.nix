{
  description = "Wil Taylor's NeoVim config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    rnix-lsp = { url = "github:nix-community/rnix-lsp"; };

    goyo = { url = "github:junegunn/goyo.vim"; flake = false; };
    everforest = { url = "github:sainnhe/everforest"; flake = false; };
    limelight = { url = "github:junegunn/limelight.vim"; flake = false; };
    yuck-vim = { url = "github:elkowar/yuck.vim"; flake = false; };
    ultisnips = { url = "github:SirVer/ultisnips"; flake = false; };
    nvim-tree-lua = { url = "github:kyazdani42/nvim-tree.lua"; flake = false; };
    vim-nix = { url = "github:LnL7/vim-nix"; flake = false; };
    vimtex = { url = "github:lervag/vimtex"; flake = false; };
    neomake = { url = "github:neomake/neomake"; flake = false; };
    nvim-dap = { url = "github:mfussenegger/nvim-dap"; flake = false; };
    telescope-dap = { url = "github:nvim-telescope/telescope-dap.nvim"; flake = false; };
    nvim-dap-virtual-text = { url = "github:theHamsta/nvim-dap-virtual-text"; flake = false; };
    neoformat = { url = "github:sbdchd/neoformat"; flake = false; };
    nvim-lightbulb = { url = "github:kosayoda/nvim-lightbulb"; flake = false; };
    lightline-vim = { url = "github:itchyny/lightline.vim"; flake = false; };
    vim-pandoc = { url = "github:vim-pandoc/vim-pandoc"; flake = false; };
    vim-pandoc-syntax = { url = "github:vim-pandoc/vim-pandoc-syntax"; flake = false; };
    vimwiki = { url = "github:vimwiki/vimwiki"; flake = false; };
    nvim-lspconfig = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    lightline-gruvbox = { url = "github:shinchu/lightline-gruvbox.vim"; flake = false; };
    completion-nvim = { url = "github:nvim-lua/completion-nvim"; flake = false; };
    nvim-which-key = { url = "github:folke/which-key.nvim"; flake = false; };
  };
  outputs = { self, nixpkgs, neovim, rnix-lsp, ... }@inputs:
  let
    plugins = [
      "goyo"
      "everforest"
      "yuck-vim"
      "ultisnips"
      "limelight"
      "nvim-tree-lua"
      "nvim-lightbulb"
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
    ];

    externalBitsOverlay = top: last: {
      rnix-lsp = rnix-lsp.defaultPackage.${top.system};
      neovim-nightly = neovim.defaultPackage.${top.system};
    };

    pluginOverlay = top: last: let
      buildPlug = name: top.vimUtils.buildVimPluginFrom2Nix {
        pname = name;
        version = "master";
        src = builtins.getAttr name inputs;
      };
    in {
      neovimPlugins = builtins.listToAttrs (map (name: { inherit name; value = buildPlug name; }) plugins);
    };
    
    allPkgs = lib.mkPkgs { 
      inherit nixpkgs; 
      cfg = { };
      overlays = [
        pluginOverlay
        externalBitsOverlay
      ];
    };

    lib = import ./lib;

    mkNeoVimPkg = pkgs: lib.neovimBuilder {
        inherit pkgs;
        config = {
          vim.viAlias = true;
          vim.vimAlias = true;
          vim.theme.everforest.enable = true;
          vim.theme.everforest.underline = true;
          vim.theme.goyo.enable = true;
          vim.theme.limelight.enable = true;
          vim.theme.lightline.enable = true;
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
          vim.filetree.nvimTreeLua.enable = true;
        };
      };

  in {

    apps.default = lib.withDefaultSystems (sys: {
      type = "app";
      program = "${self.defaultPackage."${sys}"}/bin/nvim";
    });

    defaultPackage = lib.withDefaultSystems (sys: self.packages."${sys}".neovimWT);

    packages = lib.withDefaultSystems (sys: {
      neovimWT = mkNeoVimPkg allPkgs."${sys}";
    });
  };
}
