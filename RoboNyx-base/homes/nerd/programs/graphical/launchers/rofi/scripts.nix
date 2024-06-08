{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) makeDesktopItem;
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  sys = modules.system;
  prg = sys.programs;

  # runs processes as systemd transient services
  rofi-run-emoji = pkgs.writeShellScriptBin "rofi-run-emoji" ''
    killall rofi || run-as-service $(rofi -modi "emoji:rofimoji" -show emoji)
  '';

  # runs processes as systemd transient services
  rofi-run-power-menu = pkgs.writeShellScriptBin "rofi-run-power-menu" ''
    killall rofi || run-as-service $(rofi -show power-menu -modi power-menu:rofi-power-menu)
  '';

  toggle-brightness = pkgs.writeShellScriptBin "toggle-brightness" ''
    #!/bin/sh
    # Get the current brightness and maximum brightness
    current=$(brightnessctl g)
    max=$(brightnessctl m)

    # Check the current brightness level
    if [ "$current" -eq "$max" ]; then
      # If brightness is max, set it to 0
      brightnessctl s 0%
    elif [ "$current" -eq 0 ]; then
      # If brightness is 0, set it to 100
      brightnessctl s 100%
    else
      # If brightness is neither 0 nor max, set it to 0
      brightnessctl s 0%
    fi
  '';
in {
  config = mkIf (prg.default.launcher == "rofi") {
    home.packages = [
      rofi-run-emoji
      rofi-run-power-menu
      toggle-brightness

      # Fake rofi dmenu entries
      (makeDesktopItem {
        name = "rofi-emoji";
        desktopName = "Open Emoji Menu";
        icon = "face-smile";
        exec = "rofi-run-emoji";
      })

      (makeDesktopItem {
        name = "rofi-power-menu";
        desktopName = "Power Menu";
        icon = "system-shutdown";
        exec = "rofi-run-power-menu";
      })

      (makeDesktopItem {
        name = "toggle-brightness";
        desktopName = "Toggle Brightness";
        icon = "display-brightness-symbolic";
        exec = "toggle-brightness";
      })
    ];
  };
}
