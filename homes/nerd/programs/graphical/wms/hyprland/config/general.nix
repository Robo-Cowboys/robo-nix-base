{
  lib,
  osConfig,
  ...
}: let
  # theming
  inherit (osConfig.modules.style.colorScheme) colors;
in {
  config = {
    wayland.windowManager.hyprland.settings = {
      general = {
        # sensitivity of the mouse cursor
        sensitivity = 0.8;

        # gaps
        gaps_in = 4;
        gaps_out = 8;

        # border thiccness
        border_size = 2;

        # active border color
        "col.active_border" = lib.mkForce "rgb(${colors.base0E}) rgb(${colors.base0C}) 45deg";

        # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
        apply_sens_to_raw = 0;
      };
    };
  };
}
