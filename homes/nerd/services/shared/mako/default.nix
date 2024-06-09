{
  osConfig,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;
  inherit (osConfig.modules.style.colorScheme) colors;

  dev = modules.device;
  acceptedTypes = ["desktop" "laptop" "lite" "hybrid"];
in {
  config = mkIf (builtins.elem dev.type acceptedTypes) {
    services = {
      mako = {
        enable = false;
        #        icons = true;
        #        actions = true;

        backgroundColor = "#${colors.base02}";
        borderColor = "#${colors.base02}";
        textColor = "#${colors.base05}";
        progressColor = "over ${colors.base02}";
        font = "Iosevka Nerd Font 12";
        # I wish the mako hm module was like the dunst one
        extraConfig = ''
          [urgency=low]
          background-color=#${colors.base00}
          border-color=#${colors.base0D}
          text-color=#${colors.base0A}

          [urgency=high]
          background-color=#${colors.base00}
          border-color=#${colors.base0D}
          text-color=#${colors.base08}
        '';

        padding = "15";
        defaultTimeout = 7000;
        borderSize = 3;
        borderRadius = 10;
      };
    };
  };
}
