_: {
  options.modules.network = {
    domain = mkOption {
      type = types.str;
      default = "cat-mirach.ts.net";
      description = ''
        The primary domain used for local network operations.

        Setting this option defines the network domain name under which all local services and machines will be addressed.
      '';
    };
  };
}
