{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  sys = config.modules.system;
in {
  config = mkIf sys.security.fprint.enable {
    # fingerprint login
    # doesn't work because thanks drivers
    services.fprintd = {
      enable = true;
      #      tod.enable = true;
      #      tod.driver = pkgs.libfprint-2-tod1-goodix;
    };

    security.pam.services = {
      login.fprintAuth = true;
      swaylock.fprintAuth = true;
    };
  };
}
