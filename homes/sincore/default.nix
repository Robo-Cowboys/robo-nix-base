{
  osConfig,
  lib,
  ...
}: let
  inherit (lib) mkDefault;

  sys = osConfig.modules.system;
in {
  imports = [
    # imported home-manager modules
    #TODO: reenable this.
    #    self.homeManagerModules.gtklock # a home-manager module for gtklock, gotta upstream it eventually

    # home impermanence
    ./impermanence

    # home package sets
    ./packages

    # programs and services that I use
    ./programs
    ./services

    # declarative system and program themes (qt/gtk)
    ./themes

    # things that don't fint anywhere else
    ./misc
  ];

  config = {
    home = {
      # Driven by the main user of the system
      username = "sincore";
      homeDirectory = "/home/sincore";
      extraOutputsToInstall = ["doc" "devdoc"];

      # <https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion>
      # I will personally strangle every moron who just puts nothing but "DONT CHANGE" next
      # to this value
      # NOTE: this is and should remain the version on which you have initiated your config
      stateVersion = mkDefault "23.11";
    };

    manual = {
      # the docs suck, so we disable them to save space
      html.enable = false;
      json.enable = false;
      manpages.enable = true;
    };

    # let HM manage itself when in standalone mode
    programs.home-manager.enable = true;

    # reload system units when changing configs
    systemd.user.startServices = mkDefault "sd-switch"; # or "legacy" if "sd-switch" breaks again
  };
}
