{lib, ...}: let
  inherit (lib) mkEnableOption;

  mkEnableOption' = desc: mkEnableOption "${desc}" // {default = true;};
in {
  options.modules.system = {
    # networking
    networking = {
      blocky.enable = mkEnableOption "Blocky";

      tailscale = {
        enable = mkEnableOption' "Tailscale";
        manageSSH = mkEnableOption' "Set tailscale to manage connections";
        autoConnect = mkEnableOption "Autoconnect to tailscale";
      };
    };
  };
}
