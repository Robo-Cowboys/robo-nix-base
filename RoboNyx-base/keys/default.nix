let
  inherit (builtins) attrValues;
  utils = {
    # helpers
    mkGlobal = list: list ++ [users.main];
  };

  users = {
    # users
    main = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIJGzMEAvaZpoBK2NKuKwH9E6tMakvXRtcclIYV2UBWy nerd@nixos"
    #main = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOSE69dmDxQ/UJ8k+8CL3lzc/PyJXXO/2aCcYQOjkTW+ sincore@sushi";
  };

  machines = {
    # hosts
    bebop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII2rJ89brY1/NDUOkqMXElvKpYKzBPNGDcOdKbwJ0s0g root@nixos"
    #suhsi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIITeldysWRlM603quJfPY/d6Vy23Bkp+w81zwJGO8F4w root@sushi";
  };

  # aliases - Update the below to group your workstations or servers so that these public keys are used across all of them.
  #      servers = attrValues {inherit (machines) helios icarus leto;};
  workstations = attrValues {inherit (machines) bebop;};
in {
  inherit (utils) mkGlobal;
  inherit (users) main;
  #      inherit (machines) helios enyo hermes icarus leto;
  inherit workstations;
}
