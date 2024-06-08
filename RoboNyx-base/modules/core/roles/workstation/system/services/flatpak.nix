{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (config) modules;
  sys = modules.system;
  serv = sys.services;
in {
  config = mkIf serv.flatpak.enable {
    services.flatpak.enable = true;
  };
}
