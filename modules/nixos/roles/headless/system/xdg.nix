{
  lib,
  config,
  ...
}: let
  inherit (lib) mkForce mapAttrs;
in {
  config = {
    xdg = mapAttrs (_: mkForce) {
      sounds.enable = false;
      mime.enable = false;
      menus.enable = false;
      icons.enable = false;
      autostart.enable = false;
    };
  };
}
