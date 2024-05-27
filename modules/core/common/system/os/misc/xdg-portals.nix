{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  sys = config.modules.system;
in {
  config = mkIf sys.video.enable {
    xdg.portal.config = {
      common = {
        "org.freedesktop.impl.portal.Secret" = [
          "gnome-keyring"
        ];
      };
    };
  };
}
