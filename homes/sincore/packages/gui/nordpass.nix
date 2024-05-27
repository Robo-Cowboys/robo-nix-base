{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf isWayland mkHyprlandService getExe';
  inherit (osConfig) modules;
  sys = modules.system;
  prg = sys.programs;
in {
  config = mkIf (prg.nordpass.enable && (isWayland osConfig)) {
    home.packages = with pkgs; [
      nordpass
    ];

    systemd.user.services = {
      nordpass = mkHyprlandService {
        Unit.Description = "Nordpass";
        Service = {
          ExecStart = "${getExe' pkgs.nordpass "nordpass"} --use-tray-icon";
          Restart = "always";
        };
      };
    };
  };
}
