{
  config,
  lib,
  ...
}: {
  config = {
    # disable sound related programs
    sound.enable = lib.mkForce false;
  };
}
