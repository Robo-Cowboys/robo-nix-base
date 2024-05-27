let
  inherit (builtins) attrValues;
  utils = {
    # helpers
    mkGlobal = list: list ++ [users.main];
  };

  users = {
    # users
    main = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIABG2T60uEoq4qTZtAZfSBPtlqWs2b4V4O+EptQ6S/ru";
  };

  machines = {
    # hosts
    suhsi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB8XojSEerAwKwXUPIZASZ5sXPPT7v/26ONQcH9zIFK+";
  };

  # aliases - Update the below to group your workstations or servers so that these public keys are used across all of them.
  #      servers = attrValues {inherit (machines) helios icarus leto;};
  workstations = attrValues {inherit (machines) suhsi;};
in {
  inherit (utils) mkGlobal;
  inherit (users) main;
  #      inherit (machines) helios enyo hermes icarus leto;
  inherit workstations;
}
