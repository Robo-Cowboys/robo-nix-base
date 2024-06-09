{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  inherit (osConfig) modules;

  env = modules.usrEnv;
  prg = env.programs;
  cfg = prg.media;
in {
  config = mkIf cfg.addDefaultPackages {
    home.packages = with pkgs;
      [
        # tools that help with media operations/management
        ffmpeg-full
        mpc_cli
        playerctl
        pavucontrol
        pulsemixer
        imv
        cantata
        easytag
        kid3
        musikcube
      ]
      ++ cfg.extraPackages;
  };
}
