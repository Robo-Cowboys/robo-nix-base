{config, ...}: {
  config = {
    users.users.root.hashedPassword = "*"; # lock root account
  };
}
