{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkMerge optional;
  inherit (config.services) tailscale;
  cfg = config.modules.system.networking.tailscale;
in {
  config = let
    key = "auth-key";
  in
    mkIf cfg.enable (mkMerge [
      {
        # make the tailscale command usable to users
        environment.systemPackages = [pkgs.tailscale];

        services.tailscale = {
          enable = true;
          extraUpFlags = optional cfg.manageSSH "--ssh";
        };
        networking.firewall = {
          trustedInterfaces = ["${tailscale.interfaceName}"];
          checkReversePath = "loose";
          allowedUDPPorts = [config.services.tailscale.port];
        };
      }
      (mkIf cfg.autoConnect {
        sops.secrets."${key}" = {
          sopsFile =
            lib.fs.get-file "secrets/tailscale/default.yaml";
          owner = config.users.users.root.name;
          reloadUnits = ["tailscale-autoconnect.service"];
        };
        # Autoconnect
        services.tailscale.authKeyFile = config.sops.secrets."${key}".path;
      })
    ]);
}
