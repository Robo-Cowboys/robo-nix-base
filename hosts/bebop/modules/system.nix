{
  modules.system = {
    mainUser = "nerd";
    fs = ["ext4" "vfat" "ntfs"];
    autoLogin = true;

    boot = {
      loader = "systemd-boot";
      enableKernelTweaks = true;
      initrd.enableTweaks = true;
      loadRecommendedModules = true;
      tmpOnTmpfs = true;
    };

    video.enable = true;
    sound.enable = true;
    bluetooth.enable = false;
    printing.enable = true;
    printing."3d".enable = true;

    networking = {
      tailscale = {
        enable = true;
        autoConnect = true;
      };
    };

    security = {
      fprint.enable = true;
    };

    virtualization = {
      enable = true;
      docker.enable = true;
      qemu.enable = false;
      podman.enable = false;
    };

    services = {
      flatpak = {
        enable = false;
        packages = [
          "flathub:app/com.nordpass.NordPass//stable"
        ];
      };
    };

    programs = {
      cli.enable = true;
      gui.enable = true;
      dev.enable = true;

      git = {
        userName = "peoplenamed";
        userEmail = "peoplenamed@gmail.com";
      };

      google-chrome.enable = true;
      signal-desktop.enable = true;
      gimp.enable = true;

      default = {
        terminal = "kitty";
      };
    };
  };
}
