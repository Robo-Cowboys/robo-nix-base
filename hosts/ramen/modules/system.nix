{
  modules.system = {
    mainUser = "sincore";
    fs = ["btrfs" "ext4" "vfat" "ntfs"];
    autoLogin = true;

    boot = {
      loader = "systemd-boot";
      enableKernelTweaks = true;
      initrd.enableTweaks = true;
      loadRecommendedModules = true;
      tmpOnTmpfs = true;
    };

    video.enable = true;
    sound.enable = false;
    bluetooth.enable = false;

    networking = {
      tailscale = {
        enable = true;
        autoConnect = true;
      };
    };

    virtualization = {
      enable = true;
      docker.enable = true;
      qemu.enable = false;
      podman.enable = false;
    };

    programs = {
      cli.enable = true;

      default = {
        terminal = "kitty";
      };
    };
  };
}
