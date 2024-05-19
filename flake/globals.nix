let
  # Define any inherited or required utilities and values
  #DON'T CHANGE THIS! It's used as a refrence point from the main nyx Repo for things like serets
  flakeRoot = ./../.;

  #Chnage this :)
  mainUser = "sincore";
  #Anything you add in this file will be globally avaliable under self.globals
in {
  inherit flakeRoot;
  inherit mainUser;
}
