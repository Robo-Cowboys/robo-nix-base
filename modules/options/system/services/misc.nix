{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  options.modules.system = {
    services = {
      flatpak = {
        enable = mkEnableOption "Flatpak";
        packages = mkOption {
          type = with types; listOf str;
          default = [];
          description = ''
            A list of packages that should be installed on the system.

          '';
        };
      };

      #
      #      nginx = mkModule {
      #        name = "Nginx";
      #        type = "webserver";
      #      };

      #      forgejo = mkModule {
      #        name = "Forgejo";
      #        type = "forge";
      #        port = 7000;
      #      };
    };
  };
}
