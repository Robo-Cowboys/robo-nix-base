{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf isWayland;
  inherit (osConfig) modules;
  inherit (modules.style.colorScheme) colors;
  sys = modules.system;
  prg = sys.programs;
in {
  config = mkIf (prg.gui.enable && (isWayland osConfig)) {
    home.packages = with pkgs; [
      swaynotificationcenter
      coreutils
    ];

    home.file = {
      ".config/swaync/style.css".text =
        ''
          @define-color base   #${colors.base00};
          @define-color mantle #${colors.base01};

          @define-color text     #${colors.base05};
          @define-color subtext0 #${colors.base05};
          @define-color subtext1 #${colors.base05};

          @define-color surface0 #${colors.base02};
          @define-color surface1 #${colors.base03};
          @define-color surface2 #${colors.base04};

          @define-color blue      #${colors.base0D};
          @define-color lavender  #${colors.base07};
          @define-color teal      #${colors.base0C};
          @define-color green     #${colors.base0B};
          @define-color yellow    #${colors.base0A};
          @define-color peach     #${colors.base09};
          @define-color red       #${colors.base08};
          @define-color mauve     #${colors.base0E};
          @define-color flamingo  #${colors.base0F};
          @define-color rosewater #${colors.base06};
        ''
        + builtins.readFile ./style.css;

      ".config/swaync/config.json".text = builtins.readFile ./config.json;
    };
  };
}
