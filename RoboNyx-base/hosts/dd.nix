  # My Main Desktop
  bebop = mkNixosSystem {
    inherit withSystem;
    hostname = "bebop";
    system = "x86_64-linux";
    modules =
      [
        ./bebop
        graphical
        workstation
        laptop
      ]
      ++ concatLists [shared homes];
    specialArgs = {inherit lib;};
  };
