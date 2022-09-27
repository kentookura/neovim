{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./core
    ./basic
    ./theme
    ./lsp
    ./editor
    ./filetree
    ./test
    ./latex
    ./purescript
  ];
}
