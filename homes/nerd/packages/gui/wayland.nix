{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf isWayland;
  inherit (osConfig) modules;
  sys = modules.system;
  prg = sys.programs;
in {
  config = mkIf (prg.gui.enable && (isWayland osConfig)) {
    home.packages = with pkgs; [
      wlogout
      swappy
    ];
  };
}
