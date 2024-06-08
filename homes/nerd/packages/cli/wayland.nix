{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  dev = osConfig.modules.device;
  meta = osConfig.meta;
  acceptedTypes = ["laptop" "desktop" "hybrid" "lite"];
in {
  config = mkIf ((builtins.elem dev.type acceptedTypes) && meta.isWayland) {
    home.packages = with pkgs; [
      # CLI
      grim
      slurp
      grim
      wl-clipboard
      pngquant
      wf-recorder
    ];
  };
}
