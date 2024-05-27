{
  osConfig,
  pkgs,
  lib,
  self',
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  sys = modules.system;
  prg = sys.programs;
in {
  config = mkIf (prg.gui.enable && sys.printing."3d".enable) {
    home.packages = with pkgs; [
      self'.packages.orca-slicer
      prusa-slicer
      openscad-unstable
    ];
  };
}
