{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./everforest.nix
    ./goyo.nix
    ./lightline.nix
    ./limelight.nix
  ];
}
