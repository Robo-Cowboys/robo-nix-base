{config, ...}: {
  config = {
    # monitor and control temparature
    services.thermald.enable = true;
  };
}
