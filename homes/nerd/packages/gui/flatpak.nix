{
  osConfig,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig) modules;

  sys = modules.system;
  profile = modules.profiles;
  serv = sys.services;
in {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  config = mkIf (profile.workstation.enable && serv.flatpak.enable) {
    services.flatpak.update.auto.enable = true;
    services.flatpak.uninstallUnmanaged = true;
    services.flatpak.remotes = [
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];
    services.flatpak.packages = [
    ];

    # Platform Integration
    overrides.global = {
      Context = {
        sockets = ["wayland" "!x11" "fallback-x11"];
        filesystems = ["~/.config/dconf:ro"];
      };

      Environment = {
        DCONF_USER_CONFIG_DIR = ".config/dconf";
        XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
      };
    };
  };
}
