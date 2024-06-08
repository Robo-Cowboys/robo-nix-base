{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (config.modules.usrEnv.desktop == "Hyprland") {
    # Window manager
    programs.hyprland.enable = true;
    security.pam.services.swaylock = {};
  };
}
