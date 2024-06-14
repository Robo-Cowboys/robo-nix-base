{
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  config = {
    sops = {
      defaultSopsFile = lib.my.getSecretFile "default.yaml";
      age = {
        keyFile = "~/.config/sops/age/keys.txt";
      };
    };
  };
}
