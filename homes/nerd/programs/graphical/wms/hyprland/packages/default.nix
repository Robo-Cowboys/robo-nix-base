{
  inputs',
  pkgs,
  ...
}: let
  packages = {
    inherit (inputs'.hyprland-contrib.packages) grimblast;
    inherit (pkgs) hyprpicker;

    hyprshot = pkgs.callPackage ./hyprshot.nix {};
    wrapper = pkgs.callPackage ./wrapper/wrapper.nix {inherit (inputs') hyprland;};
    dbus-hyprland-env = pkgs.callPackage ./dbus-hyprland-env.nix {};
  };
in
  packages
