{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkForce mkDefault;
in {
  config = {
    services.openssh = {
      # enable openssh
      enable = true;
      openFirewall = true; # the ssh port(s) should be automatically passed to the firewall's allowedTCPports
      ports = [30]; # the port(s) openssh daemon should listen on
      startWhenNeeded = true; # automatically start the ssh daemon when it's required
      settings = {
        # no root login
        PermitRootLogin = mkForce "no";

        # no password auth
        # force publickey authentication only
        PasswordAuthentication = false;
        AuthenticationMethods = "publickey";
        PubkeyAuthentication = "yes";
        ChallengeResponseAuthentication = "no";
        UsePAM = false;

        # remove sockets as they get stale
        # this will unbind gnupg sockets if they exists
        StreamLocalBindUnlink = "yes";

        KbdInteractiveAuthentication = mkDefault false;
        UseDns = false; # no
        X11Forwarding = false; # ew xorg

        # kick out inactive sessions
        ClientAliveCountMax = 5;
        ClientAliveInterval = 60;

        # max auth attempts
        MaxAuthTries = 3;
      };

      hostKeys = mkDefault [
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };
  };
}
