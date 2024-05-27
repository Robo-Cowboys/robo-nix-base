{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  yubikeySupport = config.modules.system.yubikeySupport;
in {
  config = mkIf yubikeySupport.enable {
    hardware.gpgSmartcards.enable = true;

    services = {
      pcscd.enable = true;
      udev.packages = [pkgs.yubikey-personalization];
    };

    programs = {
      ssh.startAgent = false;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    environment.systemPackages = with pkgs; [
      # Yubico's official tools
      yubikey-manager # cli
      yubikey-manager-qt # gui
      yubikey-personalization # cli
      yubikey-personalization-gui # gui
      yubico-piv-tool # cli
      #yubioath-flutter # gui
    ];
  };
}
