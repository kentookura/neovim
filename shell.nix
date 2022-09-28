{pkgs ? import <nixpkgs> {}}: let
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
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
