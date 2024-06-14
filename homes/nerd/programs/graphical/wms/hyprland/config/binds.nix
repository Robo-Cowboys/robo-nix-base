{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe getExe';
in {
  config = {
    wayland.windowManager.hyprland.settings = {
      # define the mod key
      "$MOD" = "SUPER";

      # keyword to toggle "monocle" - a.k.a no_gaps_when_only
      "$kw" = "dwindle:no_gaps_when_only";
      "$disable" = ''act_opa=$(hyprctl getoption "decoration:active_opacity" -j | jq -r ".float");inact_opa=$(hyprctl getoption "decoration:inactive_opacity" -j | jq -r ".float");hyprctl --batch "keyword decoration:active_opacity 1;keyword decoration:inactive_opacity 1"'';
      "$enable" = ''hyprctl --batch "keyword decoration:active_opacity $act_opa;keyword decoration:inactive_opacity $inact_opa"'';
      #"$screenshotarea" = ''hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copysave area; hyprctl keyword animation "fadeOut,1,4,default"''

      bind = [
        # Misc
        "$MODSHIFT, Escape, exec, rofi-power-menu" # logout menu
        #      "$MODSHIFT, L, exec, ${locker}" # lock the screen with swaylock
        "$MODSHIFT,E,exit," # exit Hyprland session

        # Daily Applications
        "$MOD,F1,exec,google-chrome-stable" # browser
        #        ''$MOD,F2,exec,run-as-service $(kitty)'' # file manager
        "$MOD,RETURN,exec, run-as-service $(kitty)" # terminal
        "$MOD,D,exec, killall rofi || run-as-service $(rofi -show drun)" # application launcher
        "$MOD,Space,exec, killall rofi || run-as-service $(rofi -show drun)" # application launcher
        #        "$MOD,equal,exec, killall rofi || run-as-service $(rofi -show calc)" # calc plugin for rofi
        "$MOD,period,exec, rofi-run-emoji" # emoji plugin for rofi

        # window operators
        "$MOD,Q,killactive," # kill focused window
        "$MOD,T,togglegroup," # group focused window
        "$MODSHIFT,G,changegroupactive," # switch within the active group
        "$MOD,V,togglefloating," # toggle floating for the focused window
        "$MOD,P,pseudo," # pseudotile focused window
        "$MOD,F,fullscreen," # fullscreen focused window
        "$MOD,M,exec,hyprctl keyword $kw $(($(hyprctl getoption $kw -j | jaq -r '.int') ^ 1))" # toggle no_gaps_when_only

        # Resize window control
        "$MOD ALT,left,resizeactive, -80 0"
        "$MOD ALT,right,resizeactive, 80 0"
        "$MOD ALT,up,resizeactive, 0 -80"
        "$MOD ALT,down,resizeactive, 0 80"

        # Move workspace controls.
        "$MOD CTRL,right,workspace,+1"
        "$MOD CTRL,left,workspace,-1"

        # workspace controls
        "$MODSHIFT,right,movetoworkspace,+1" # move focused window to the next ws
        "$MODSHIFT,left,movetoworkspace,-1" # move focused window to the previous ws
        "$MOD,mouse_down,workspace,e+1" # move to the next ws
        "$MOD,mouse_up,workspace,e-1" # move to the previous ws

        # focus controls
        "$MOD, left, movefocus, l" # move focus to the window on the left
        "$MOD, right, movefocus, r" # move focus to the window on the right
        "$MOD, up, movefocus, u" # move focus to the window above
        "$MOD, down, movefocus, d" # move focus to the window below

        # screenshot and receording binds
        #TODO: Fix these
        #      ''$MODSHIFT,P,exec,$disable; grim - | wl-copy --type image/png && notify-send "Screenshot" "Screenshot copied to clipboard"; $enable''
        #      "$MODSHIFT,S,exec,$disable; hyprshot; $enable" # screenshot and then pipe it to swappy
        ", Print, exec, grimblast --notify --cursor copy area" # copy selection area
        "$MOD, Print, exec, grimblast --notify --cursor copysave output" # copy all active outputs
        "$ALTSHIFT, S, exec, grimblast --notify --cursor copysave screen" # copy active screen
        "$ALTSHIFT, R, exec, grimblast --notify --cursor copysave area" # copy selection area

        #       brightness controls
        '',XF86MonBrightnessUp,exec, ${getExe pkgs.brightnessctl} set +5%''
        '',XF86MonBrightnessDown,exec, ${getExe pkgs.brightnessctl} set 5%-''

        ",XF86AudioRaiseVolume, exec, ${getExe' pkgs.pulseaudio "pactl"}  set-sink-volume @DEFAULT_SINK@ +6%"
        ",XF86AudioLowerVolume, exec, ${getExe' pkgs.pulseaudio "pactl"}  set-sink-volume @DEFAULT_SINK@ 6%-"
      ];

      bindm = [
        "$MOD,mouse:272,movewindow"
        "$MOD,mouse:273,resizewindow"
      ];
      # binds that will be repeated, a.k.a can be held to toggle multiple times
      binde = [
        # volume controls
        ",XF86AudioRaiseVolume, exec, ${getExe' pkgs.pulseaudio "pactl"}  set-sink-volume @DEFAULT_SINK@ +6%"
        ",XF86AudioLowerVolume, exec, ${getExe' pkgs.pulseaudio "pactl"}  set-sink-volume @DEFAULT_SINK@ 6%-"

        #       brightness controls
        '',XF86MonBrightnessUp,exec, ${getExe pkgs.brightnessctl} set +5%''
        '',XF86MonBrightnessDown,exec, ${getExe pkgs.brightnessctl} set 5%-''

        #       keyboard brightness controls
        '',XF86KbdBrightnessUp,exec, ${getExe pkgs.brightnessctl} -d asus::kbd_backlight set +1''
        '',XF86KbdBrightnessDown,exec, ${getExe pkgs.brightnessctl} -d asus::kbd_backlight set 1-''
      ];

      # binds that are locked, a.k.a will activate even while an input inhibitor is active
      bindl = [
        ", XF86AudioMute, exec, ${getExe' pkgs.pulseaudio "pactl"} set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, ${getExe' pkgs.pulseaudio "pactl"} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];
    };
  };
}
