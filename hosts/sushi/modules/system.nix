{
  modules.system = {
    mainUser = "sincore";
    fs = ["btrfs" "ext4" "vfat" "ntfs"];
    autoLogin = false;

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
        userName = "use-the-fork";
        userEmail = "sincore@gmail.com";
      };

      google-chrome.enable = true;
      signal-desktop.enable = true;
      nordpass.enable = true;
      gimp.enable = false;

      default = {
        terminal = "kitty";
      };
    };
  };
}
