{
  modules.system = {
    mainUser = "nerd";
    #    fs = ["btrfs" "ext4" "vfat" "ntfs"];
    fs = ["ext4" "vfat" "ntfs"];
    impermanence.root.enable = false;
    autoLogin = false;

    boot = {
      loader = "systemd-boot";
      enableKernelTweaks = true;
      initrd.enableTweaks = true;
      loadRecommendedModules = true;
      tmpOnTmpfs = false;
    };

    video.enable = true;
    sound.enable = true;
    bluetooth.enable = false;
    printing.enable = false;
    printing."3d".enable = false;

    networking = {
      tailscale = {
        enable = false;
        autoConnect = false;
      };
    };

    security = {
      fprint.enable = false;
    };

    virtualization = {
      enable = false;
      docker.enable = false;
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
      nordpass.enable = false;
      gimp.enable = false;
      mission-planner.enable = true;

      default = {
        terminal = "kitty";
      };
    };
  };
}
