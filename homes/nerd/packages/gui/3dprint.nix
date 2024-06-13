_: {
  config = {
    home.packages = with pkgs; [
      self'.packages.orca-slicer
      prusa-slicer
      openscad-unstable
    ];
  };
}
