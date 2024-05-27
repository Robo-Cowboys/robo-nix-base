{config, ...}: {
  config = {
    users.extraUsers.root.password = "";

    users.users.nixos = {
      password = "nixos";
      description = "default";
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };
}
