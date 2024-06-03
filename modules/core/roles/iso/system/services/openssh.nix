{config, ...}: {
  config = {
    services.openssh = {
      # enable openssh
      enable = true;
      openFirewall = true;
    };
  };
}
