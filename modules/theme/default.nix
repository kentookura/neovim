{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./gruvbox.nix
    ./everforest.nix
    ./goyo.nix
    ./lightline.nix
    ./limelight.nix
  ];
}
