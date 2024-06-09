{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe getExe';
  #  brightnessctl = pkgs.writeShellScriptBin "toggle-brightness" ''
  #                    #!/bin/sh
  #                    # Get the current brightness and maximum brightness
  #                    current=$(brightnessctl g)
  #                    max=$(brightnessctl m)
  #
  #                    # Check the current brightness level
  #                    if [ "$current" -eq "$max" ]; then
  #                      # If brightness is max, set it to 0
  #                      brightnessctl s 0%
  #                    elif [ "$current" -eq 0 ]; then
  #                      # If brightness is 0, set it to 100
  #                      brightnessctl s 100%
  #                    else
  #                      # If brightness is neither 0 nor max, set it to 0
  #                      brightnessctl s 0%
  #                    fi
  #                  '';
in {
  "clock" = {
    "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    "format" = "{:%I:%M %p }";
    "format-alt" = "{:%Y-%m-%d}";
  };

  "cpu" = {
    "format" = "  {usage}%";
    "tooltip" = true;
  };

  "disk" = {
    "format" = "  {percentage_used}%";
  };

  "idle_inhibitor" = {
    "format" = "{icon} ";
    "format-icons" = {
      "activated" = "";
      "deactivated" = "";
    };
  };

  "keyboard-state" = {
    "numlock" = true;
    "capslock" = true;
    "format" = "{icon} {name}";
    "format-icons" = {
      "locked" = "";
      "unlocked" = "";
    };
  };

  "memory" = {
    "format" = "󰍛  {}%";
  };

  "mpris" = {
    "format" = "{player_icon} {status_icon} {dynamic}";
    "format-paused" = "{player_icon} {status_icon} <i>{dynamic}</i>";
    "max-length" = 45;
    "player-icons" = {
      "chromium" = "";
      "default" = "";
      "firefox" = "";
      "mopidy" = "";
      "mpv" = "";
      "spotify" = "";
    };
    "status-icons" = {
      "paused" = "";
      "playing" = "";
      "stopped" = "";
    };
  };

  "network" = {
    "interval" = 1;
    "format-wifi" = "  󰜮 {bandwidthDownBytes} 󰜷 {bandwidthUpBytes}";
    "format-ethernet" = "󰈀  󰜮 {bandwidthDownBytes} 󰜷 {bandwidthUpBytes}";
    "tooltip-format" = " {ifname} via {gwaddr}";
    "format-linked" = "󰈁 {ifname} (No IP)";
    "format-disconnected" = " Disconnected";
    "format-alt" = "{ifname}: {ipaddr}/{cidr}";
  };

  "backlight" = {
    format = "{icon} {percent}%";
    format-icons = ["󰛩" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
    tooltip-format = "{percent}%";
    "scroll-step" = 5;
  };

  "battery" = {
    format = "{icon} {capacity}% ";
    states = {
      warning = 30;
      critical = 15;
    };
    format-charging = "󰂄";
    format-plugged = "󰂄";
    format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
  };

  "pulseaudio" = {
    "format" = "{icon} {volume}%";
    "format-bluetooth" = "{icon} {volume}%";
    "format-muted" = "";
    "format-icons" = {
      "headphone" = "";
      "hands-free" = "";
      "headset" = "";
      "phone" = "";
      "portable" = "";
      "car" = "";
      "default" = [
        ""
        ""
      ];
    };
    "scroll-step" = 1;
    "on-click" = "pavucontrol";
    "ignored-sinks" = [
      "Easy Effects Sink"
    ];
  };

  "systemd-failed-units" = {
    "hide-on-ok" = false;
    "format" = "✗ {nr_failed}";
    "format-ok" = "✓";
    "system" = true;
    "user" = false;
  };

  "tray" = {
    "spacing" = 10;
  };

  "user" = {
    "format" = "{user}";
    "interval" = 60;
    "height" = 30;
    "width" = 30;
    "icon" = true;
  };

  "wireplumber" = {
    "format" = "{volume}% {icon}";
    "format-muted" = "󰖁";
    "on-click" = "${getExe' pkgs.coreutils "sleep"} 0.1 && ${getExe pkgs.helvum}";
    "format-icons" = [
      ""
      ""
      ""
    ];
  };
}
