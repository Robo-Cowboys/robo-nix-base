{
  config.modules.system = {
    mainUser = "nerd";
    users = ["nerd"];
    fs = ["ext4" "vfat" "ntfs" "exfat"];
    autoLogin = false;

    boot = {
      loader = "none";
      enableKernelTweaks = true;
      initrd.enableTweaks = true;
      tmpOnTmpfs = false;
    };

    video.enable = false;
    sound.enable = false;
    bluetooth.enable = false;
    printing.enable = false;

    virtualization.enable = false;

    networking = {
      tailscale = {
        enable = true;
      };
    };
  };
}
