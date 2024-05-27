{
  config,
  lib,
  ...
}: let
  inherit (lib) mkForce;
in {
  config = {
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        log-lines = 30;
        warn-dirty = false;
        http-connections = 50;
        accept-flake-config = mkForce true;
        auto-optimise-store = true;

        flake-registry = mkForce "";
      };
    };
  };
}
