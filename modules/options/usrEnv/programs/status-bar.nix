{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.modules.usrEnv.wayland.statusBar = {
    ags.enable = mkEnableOption "ags status bar";
    waybar.enable = mkEnableOption "waybar status bar";
  };
}
