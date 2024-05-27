{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkOption mkEnableOption types;
in {
  imports = [
    ./gtk.nix
    ./qt.nix
    ./colors.nix
    ./fonts.nix
  ];

  options.modules.style = {
    forceGtk = mkEnableOption "Force GTK applications to use the GTK theme";
    useKvantum = mkEnableOption "Use Kvantum to theme QT applications";

    pointerCursor = {
      package = mkOption {
        type = types.package;
        description = "The package providing the cursors";
        default = pkgs.catppuccin-cursors.mochaDark;
      };

      name = mkOption {
        type = types.str;
        description = "The name of the cursor inside the package";
        default = "Catppuccin-Mocha-Dark-Cursors";
      };

      size = mkOption {
        type = types.int;
        description = "The size of the cursor";
        default = 24;
      };
    };

    wallpaper = mkOption {
      type = with types; str;
      description = "Wallpaper to use relative to the wallpackages repo";
      default = "catppuccin/01.png";
    };
  };
}
