{
  lib,
  config,
  ...
}:
with lib; {
  imports = [
    ./touchpad.nix
  ];

  config = {
    powerManagement.enable = true;

    services = {
      logind = {
        lidSwitch = "suspend-then-hibernate";
        lidSwitchExternalPower = "suspend-then-hibernate";
        extraConfig = ''
          HandlePowerKey=suspend-then-hibernate
          HibernateDelaySec=3600
        '';
      };

      upower.enable = true;
    };
  };
}
