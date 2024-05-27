{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  virt = config.modules.system.virtualization;
in {
  config = mkIf (virt.enable && virt.docker.enable) {
    environment.systemPackages = with pkgs; [docker-compose];
    virtualisation.docker.enable = true;
  };
}
