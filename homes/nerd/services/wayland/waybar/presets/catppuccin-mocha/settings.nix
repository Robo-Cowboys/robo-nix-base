{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkMerge;

  custom-modules = import ./modules/custom-modules.nix {inherit config lib pkgs;};
  default-modules = import ./modules/default-modules.nix {inherit lib pkgs;};
  group-modules = import ./modules/group-modules.nix;
  hyprland-modules = import ./modules/hyprland-modules.nix {inherit config lib;};

  all-modules = mkMerge [
    custom-modules
    default-modules
    group-modules
    hyprland-modules
  ];

  bar = {
    position = "top";
    layer = "top";

    margin-top = 2;
    margin-bottom = 2;
    margin-left = 0;
    margin-right = 0;
  };

  mainBar = {
    modules-left = [
      "hyprland/workspaces"
      "custom/separator-left"
      "hyprland/window"
    ];
    modules-center = [
    ];
    modules-right = [
      "group/stats"
      "group/notifications"
      "group/utilities"
      "tray"
      "hyprland/submap"
      "clock"
    ];
  };
in {
  mainBar = mkMerge [bar mainBar all-modules];
}
