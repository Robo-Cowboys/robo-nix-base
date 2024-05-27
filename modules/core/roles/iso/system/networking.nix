{
  self',
  lib,
  config,
  ...
}: let
  inherit (lib) mkForce;
in {
  config = {
    networking.networkmanager = {
      enable = true;
      plugins = mkForce [];
    };

    networking.wireless.enable = mkForce false;

    # Enable SSH in the boot process.
    systemd.services.sshd.wantedBy = mkForce ["multi-user.target"];
    users.users.root.openssh.authorizedKeys.keys = [
      #add in the main user SSH key
      self'.keys.main
    ];
  };
}
