{config, ...}: let
  sys = config.modules.system;
in {
  config = {
    # Useful package to simplify nix commands
    # https://github.com/viperML/nh
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 5";
      flake = "/home/${sys.mainUser}/.config/dots/RoboNyx-base";
    };
  };
}
