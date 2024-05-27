{
  self,
  pkgs,
  config,
  ...
}: let
  keys = [
    self.keys.main
  ];
  sys = config.modules.system;
in {
  config = {
    boot.initrd.network.ssh.authorizedKeys = keys;

    users.users."${sys.mainUser}" = {
      isNormalUser = true;
      shell = pkgs.zsh;
      initialPassword = "changeme";
      openssh.authorizedKeys.keys = keys;
      extraGroups = [
        "wheel"
        "gitea"
        "docker"
        "systemd-journal"
        "vboxusers"
        "audio"
        "plugdev"
        "video"
        "input"
        "lp"
        "networkmanager"
        "power"
        "nix"
      ];
      uid = 1000;
    };
  };
}
