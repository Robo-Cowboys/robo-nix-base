{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe mkIf;

  env = osConfig.modules.usrEnv;
  locker = getExe env.programs.screenlock.package;
in {
  config = mkIf (env.desktop == "Hyprland") {
    systemd.user.services.swayidle.Install.WantedBy = ["hyprland-session.target"];

    # screen idle
    services.swayidle = {
      enable = true;
      extraArgs = ["-d" "-w"];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          event = "lock";
          command = "${locker}";
        }
      ];
      timeouts = [
        {
          timeout = 300;
          command = "${getExe pkgs.swaylock-effects} -fF";
          #          resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
