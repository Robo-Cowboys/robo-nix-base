{
  config = {
    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        # only allow shadows for floating windows
        "noshadow, floating:0"

        "float,class:udiskie"

        # NordPass
        "float,class:NordPass"

        "idleinhibit focus,class:kitty"

        # firefox
        "idleinhibit fullscreen, class:^(firefox)$"
        "float,title:^(Firefox — Sharing Indicator)$"
        "move 0 0,title:^(Firefox — Sharing Indicator)$"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"

        # pavucontrol
        "float,class:pavucontrol"
        "float,title:^(Volume Control)$"
        "size 800 600,title:^(Volume Control)$"
        "move 75 44%,title:^(Volume Control)$"
        "float, class:^(imv)$"
        "opacity 1.0 override 1.0 override, title:^(.*imv.*)$"
        "opacity 1.0 override 1.0 override, title:^(.*mpv.*)$"
        "opacity 1.0 override 1.0 override, class:(Aseprite)"
        "opacity 1.0 override 1.0 override, class:(Unity)"
        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit fullscreen, class:^(chrome)$"

        "rounding 0, xwayland:1"

        "workspace 6 silent, class:^(signal)$"

        # JetBrains - Enhanced rules
        # -- Fix odd behaviors in IntelliJ IDEs --
        "windowdance,class:^(jetbrains-.*)$,floating:1"

        #! Fix splash screen showing in weird places and prevent annoying focus takeovers
        "center,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
        "nofocus,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
        "noborder,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"

        #! Center popups/find windows
        "center,class:^(jetbrains-.*)$,title:^( )$,floating:1"
        "stayfocused,class:^(jetbrains-.*)$,title:^( )$,floating:1"
        "noborder,class:^(jetbrains-.*)$,title:^( )$,floating:1"

        #! Disable window flicker when autocomplete or tooltips appear
        "nofocus,class:^(jetbrains-.*)$,title:^(win.*)$,floating:1"
      ];
    };
  };
}
