{
  "group/battery" = {
    "orientation" = "horizontal";
    "modules" = [
      "battery"
    ];
  };

  "group/utilities" = {
    "orientation" = "horizontal";
    "modules" = [
      "custom/colorpicker"
    ];
  };

  "group/notifications" = {
    "orientation" = "horizontal";
    "modules" = [
      "backlight"
      "pulseaudio"
      "group/battery"
      "custom/notification"
    ];
  };

  "group/stats" = {
    "orientation" = "horizontal";
    "modules" = [
      "network"
      "cpu"
      "memory"
      "disk"
    ];
  };

  "group/stats-drawer" = {
    "orientation" = "horizontal";
    #    "drawer" = {
    #      "transition-duration" = 100;
    #      "transition-left-to-right" = false;
    #    };
    "modules" = [
      "network"
      "cpu"
      "memory"
      "disk"
    ];
  };
}
