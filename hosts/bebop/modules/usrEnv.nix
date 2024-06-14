{
  modules.usrEnv = {
    desktop = "Hyprland";
    wayland = {
      statusBar = {
        waybar.enable = true;
      };
    };
    programs.screenlock.swaylock.enable = true;
  };
}
