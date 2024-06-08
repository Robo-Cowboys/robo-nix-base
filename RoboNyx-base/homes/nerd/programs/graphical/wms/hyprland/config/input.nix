{
  config = {
    wayland.windowManager.hyprland.settings = {
      input = {
        # keyboard layout
        kb_layout = "us";
        # self explanatory, I hope?
        follow_mouse = 2;
        float_switch_override_focus = 1;
        # do not imitate natural scroll
        touchpad.natural_scroll = "no";
        # ez numlock enable
        numlock_by_default = true;
      };
    };
  };
}
