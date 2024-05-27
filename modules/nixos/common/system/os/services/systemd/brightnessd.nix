{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  env = config.modules.usrEnv;
  cfg = env.brightness;
in {
  config = mkIf cfg.enable {
    systemd.services."system-brightnessd" = {
      description = "Automatic backlight management with systemd";

      # TODO: maybe this needs to be a part of graphical-session.target?
      # I am not very sure how wantedBy and partOf really work
      wantedBy = ["default.target"];
      partOf = ["graphical-session.target"];

      serviceConfig = {
        Type = "${cfg.serviceType}";
        ExecStart = "${lib.getExe cfg.package}";
        Restart = "never";
        RestartSec = "5s";
      };
    };
  };
}
