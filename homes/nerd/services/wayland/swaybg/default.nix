{
  pkgs,
  lib,
  osConfig,
  inputs',
  ...
}: let
  inherit (lib) mkIf getExe;
  inherit (osConfig) modules;
  inherit (lib) isWayland mkHyprlandService;

  style = modules.style;
  env = modules.usrEnv;
  wallpkgs = inputs'.wallpkgs.packages;
in {
  config = mkIf ((isWayland osConfig) && (env.wallpaperService == "swaybg")) {
    systemd.user.services = {
      swaybg = mkHyprlandService {
        Unit.Description = "Wallpaper chooser service";
        Service = let
          wall = "${wallpkgs.catppuccin}/share/wallpapers/${style.wallpaper}";
        in {
          ExecStart = "${getExe pkgs.swaybg} -i ${wall} -m fill";
          Restart = "always";
        };
      };
    };
  };
}
