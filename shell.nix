{pkgs ? import <nixpkgs> {}}: let
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      nodePackages.purescript-language-server
      ltex-ls
      texlab
      haskell-language-server
      fzf
      pstree # for vimtex
      pplatex
      sumneko-lua-language-server
      pulp
      silver-searcher
      ctags
      proselint
      cabal-install
      haskell-language-server
      hlint
      ghcid
      ormolu
      haskellPackages.implicit-hie
    ];
    shellHook = ''
    '';
  }
