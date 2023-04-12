
{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.typescript;
in {
  options.vim.typescript = {
    enable = mkEnableOption "Enable typescript support";
  };
  config = let
  in {
  };
}
