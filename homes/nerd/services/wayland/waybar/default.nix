{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig.modules.style.colorScheme) slug colors;

  env = osConfig.modules.usrEnv;

  waybar_config = import ./presets/${slug}/settings.nix {inherit osConfig config lib pkgs;};
  waybar_style = import ./presets/${slug}/style.nix {inherit colors;};
in {
  config = mkIf (env.wayland.statusBar.waybar.enable && (lib.isWayland osConfig)) {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = waybar_config;
      style = waybar_style;
    };
    #    programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
    #      mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
    #    });
    home.packages = with pkgs; [
      brightnessctl
      hyprpicker
    ];
  };
}
