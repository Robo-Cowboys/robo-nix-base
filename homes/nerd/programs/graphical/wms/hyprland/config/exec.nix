{osConfig, ...}: let
  inherit (osConfig) modules;

  # theming
  inherit (modules.style) pointerCursor;
in {
  config = {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        # set cursor for HL itself
        "hyprctl setcursor ${pointerCursor.name} ${toString pointerCursor.size}"
        #        "[workspace 6 silent] nordpass --use-tray-icon"
      ];
    };
  };
}
