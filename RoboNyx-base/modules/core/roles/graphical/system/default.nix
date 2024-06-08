{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./services
  ];

  config = {
    # Enable the XFCE Desktop Environment.
    #  services.xserver.displayManager.lightdm.enable = true;
    #  services.xserver.desktopManager.xfce.enable = true;

    #services.xserver.enable = true;
    #services.xserver.displayManager.sddm.enable = true;
    #services.xserver.desktopManager.plasma5.enable = true;

    #Plasma
    #services.xserver.displayManager.defaultSession = "plasma";
    #services.xserver.displayManager.sddm.wayland.enable = true;

    #xdg.portal = {
    #  enable = true;
    #  wlr.enable = true;
    #  xdgOpenUsePortal = true;
    #  extraPortals = [
        #        pkgs.xdg-desktop-portal-hyprland
    #    pkgs.xdg-desktop-portal-gtk
    #  ];
    #};

    # Display manager
    services = {
      gvfs.enable = true;
      gnome = {
        gnome-keyring.enable = true;
      };

      dbus.enable = true;

      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
    };
  };
}
