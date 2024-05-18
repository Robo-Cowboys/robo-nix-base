let
  # Define any inherited or required utilities and values
  inherit (builtins) attrValues;

  flakeRoot = ./../.;
  mainUser = "sincore";
in {
  inherit flakeRoot;
  inherit mainUser;
}
