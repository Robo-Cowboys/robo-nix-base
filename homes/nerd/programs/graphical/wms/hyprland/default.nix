{
  inputs',
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig) modules;

  inherit (import ./packages {inherit inputs' pkgs;}) grimblast hyprshot dbus-hyprland-env;

  env = modules.usrEnv;
in {
  imports = [
    ./config/binds.nix
    ./config/decorations.nix
    ./config/exec.nix
    ./config/extraConfig.nix
    ./config/general.nix
    ./config/input.nix
    ./config/layout.nix
    ./config/misc.nix
    ./config/windowrules.nix
  ];

  config = mkIf env.desktops.hyprland.enable {
    home.packages = [
      hyprshot
      grimblast
      #      inputs'.hyprpicker.packages
      dbus-hyprland-env
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = env.desktops.hyprland.package;
      xwayland.enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
    };
  };
}
