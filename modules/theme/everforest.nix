{ pkgs, config, lib, ...}:
with lib;
with builtins;

let
  cfg = config.vim.theme.everforest;
  everforestPallete = [
    "bg" "red" "green" "yellow" "blue" "purple" "aqua" "gray" 
    "orange" "bg0" "bg1" "bg2" "bg3" "bg4"
    "fg0" "fg1" "fg2" "fg3" "fg4" "none"
  ];
in {
  options.vim.theme.everforest = {
    enable = mkEnableOption "Enable everforest theme";

    bold = mkOption {
      default = true;
      description = "Enable bold text";
      type = types.bool;
    };

    italic = mkOption {
      default = false;
      description = "Enable italic text";
      type = types.bool;
    };

    transparentBackground = mkOption {
      default = false;
      description = "Enable transparent background";
      type = types.bool;
    };

    underline = mkOption {
      default = true;
      description = "Enable underlined text";
      type = types.bool;
    };

    undercurl = mkOption {
      default = true;
      description = "Enable undercurl text";
      type = types.bool;
    };

    termColours = mkOption {
      default = "256";
      description = "Uses 256 term colours by default. If there is a issue set to 16";
      type = types.str;
    };

    contrastDark = mkOption {
      default = "medium";
      description = "The contrast when in dark mode. Can be soft, medium or hard";
      type = types.enum [ "soft" "medium" "hard"];
    };

    contrastLight = mkOption {
      default = "medium";
      description = "The contrast when in light mode. Can be soft, medium or hard";
      type = types.enum [ "soft" "medium" "hard"];
    };

    hlsCursor = mkOption {
      default = "orange";
      description = "Everforest Pallete to assign to search highlight cursor";
      type = types.enum everforestPallete; 
    };

    numberColumn = mkOption {
      default = "none";
      description = "Everforest Pallete to assign to the number column background";
      type = types.enum everforestPallete;
    };

    signColumn = mkOption {
      default = "bg1";
      description = "Everforest Pallete to assign to the sign column background";
      type = types.enum everforestPallete;
    };

    colourColumn = mkOption {
      default = "bg1";
      description = "Everforest Pallete to assign to the colour column background";
      type = types.enum everforestPallete;
    };

    virticalSplit = mkOption {
      default = "bg0";
      description = "Everforest Pallete to assign to the virtical split background";
      type = types.enum everforestPallete;
    };

    italicComments = mkOption {
      default = true;
      description = "Enable italics for comments";
      type = types.bool;
    };

    italicStrings = mkOption {
      default = false;
      description = "Enable italics for strings";
      type = types.bool;
    };

    invertSelected = mkOption {
      default = true;
      description = "Invert colours of selected text";
      type = types.bool;
    };

    invertSigns = mkOption {
      default = false;
      description = "Invert colours of signs. Useful for gitgutter";
      type = types.bool;
    };

    invertIdentGuides = mkOption {
      default = false;
      description = "Inverts indent guides";
      type = types.bool;
    };

    invertTabline = mkOption {
      default = false;
      description = "Invert the tabline highlights, providing distinguishable tabline-fill";
      type = types.bool;
    };

    improvedStrings = mkOption {
      default = false;
      description = "Extrahighlighted strings";
      type = types.bool;
    };

    improvedWarnings = mkOption {
      default = false;
      description = "Extrahighlighted warnings";
      type = types.bool;
    };
  };

  config = mkIf (cfg.enable) 
  (let
    mkVimBool = val: if val then "1" else "0";
    mkIfNotNone = val: if val == "none" then null else val;
  in {
    vim.configRC = ''
      colorscheme everforest
    '';

    vim.startPlugins = with pkgs.neovimPlugins; [everforest];
    vim.globals = {
      "everforest_bold" = mkVimBool cfg.bold;
      "everforest_italic" = mkVimBool cfg.italic;
      "everforest_transparent_bg" = mkVimBool cfg.transparentBackground;
      "everforest_underline" = mkVimBool cfg.underline;
      "everforest_undercurl" = mkVimBool cfg.undercurl;
      "everforest_termcolors" = mkIfNotNone cfg.termColours;
      "everforest_contrast_dark" = mkIfNotNone cfg.contrastDark;
      "everforest_contrast_light" = mkIfNotNone cfg.contrastLight;
      "everforest_hls_cursor" = mkIfNotNone cfg.hlsCursor;
      "everforest_number_column" = mkIfNotNone cfg.numberColumn;
      "everforest_sign_column" = mkIfNotNone cfg.signColumn;
      "everforest_virt_split" = mkIfNotNone cfg.virticalSplit;
      "everforest_italicize_comments" = mkVimBool cfg.italicComments;
      "everforest_italicize_strings" = mkVimBool cfg.italicStrings;
      "everforest_invert_selection" = mkVimBool cfg.invertSelected;
      "everforest_invert_signs" = mkVimBool cfg.invertSigns;
      "everforest_invert_ident_guides" = mkVimBool cfg.invertIdentGuides;
      "everforest_invert_tabline" = mkVimBool cfg.invertTabline;
      "everforest_improved_strings" = mkVimBool cfg.improvedStrings;
      "everforest_improved_warnings" = mkVimBool cfg.improvedWarnings;
    };
  });
}
