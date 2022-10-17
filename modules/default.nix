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
    ./languages
    ./editor
    ./filetree
    ./test
    ./git
  ];
}
