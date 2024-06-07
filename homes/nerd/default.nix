{inputs, ...}: {
  imports = [
    #this is the common configs brought in from the nyx package.
    "${inputs.robo-nyx}/modules/home"
  ];

  config = {
  };
}
