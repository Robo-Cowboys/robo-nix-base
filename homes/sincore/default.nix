{inputs, ...}: {
  imports = [
    #this is the common configs brought in from the nyx package.
    "${inputs.nyx}/modules/home"
  ];

  config = {
  };
}
