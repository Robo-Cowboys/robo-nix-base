{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  sys = modules.system;
  prg = sys.programs;
in {
  config = mkIf prg.mission-planner.enable {
    home.packages = with pkgs; [
      mission-planner
    ];
  };
}
