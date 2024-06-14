{
  withSystem,
  inputs,
  ...
}: let
  # self.lib is an extended version of nixpkgs.lib
  # mkNixosIso and mkNixosSystem are my own builders for assembling a nixos system
  # provided by my local extended library
  inherit (inputs.self) lib;
  inherit (lib) concatLists mkNixosIso mkNixosSystem;

  ## flake inputs ##
  hw = inputs.nixos-hardware.nixosModules; # hardware compat for pi4 and other quirky devices
  sops-nix = inputs.sops-nix.nixosModules.default; # secret encryption via age
  disko = inputs.disko.nixosModules.disko; # disko for disk setup and easier volume mangment.
  hm = inputs.home-manager.nixosModules.home-manager; # home-manager nixos module

  # serializing the modulePath to a variable
  # this is in case the modulePath changes depth (i.e modules becomes nixos/modules)
  modulePath = ../modules;

  coreModules = modulePath + /core; # the path where common modules reside
  #  extraModules = modulePath + /extra; # the path where extra modules reside
  options = modulePath + /options; # the module that provides the options for my system configuration

  ## common modules ##
  common = coreModules + /common; # the self-proclaimed sane defaults for all my systems
  profiles = coreModules + /profiles; # force defaults based on selected profile

  # roles
  iso = coreModules + /roles/iso; # for providing a uniform ISO configuration for live systems - only the build setup
  headless = coreModules + /roles/headless; # for devices that are of the headless type - provides no GUI
  graphical = coreModules + /roles/graphical; # for devices that are of the graphical type - provides a GUI
  workstation = coreModules + /roles/workstation; # for devices that are of workstation type - any device that is for daily use
  server = coreModules + /roles/server; # for devices that are of the server type - provides online services
  laptop = coreModules + /roles/laptop; # for devices that are of the laptop type - provides power optimizations

  # home-manager
  homesDir = ../homes; # home-manager configurations for hosts that need home-manager
  homes = [hm homesDir]; # combine hm flake input and the home module to be imported together

  # a list of shared modules that ALL systems need
  shared = [
    common # the "sane" default shared across systems
    options # provide options for defined modules across the system
    disko # TODO: should this be on a per host or shared?
    sops-nix # age encryption for secrets
    profiles # profiles program overrides per-host
  ];
in {
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

  # Raspberry Pi 400
  # My Pi400 homelab
  # used mostly for testing networking/cloud services
  raspberry = mkNixosSystem {
    inherit withSystem;
    hostname = "raspberry";
    system = "aarch64-linux";
    modules =
      [
        ./raspberry
        server
        headless

        # get raspberry pi 4 modules from nixos-hardware
        hw.raspberry-pi-4
      ]
      ++ shared;
    specialArgs = {inherit lib;};
  };

  # Self-made live recovery environment that overrides or/and configures certain default programs
  # provides tools and fixes the keymaps for my keyboard
  installer = mkNixosIso {
    hostname = "installer";
    system = "x86_64-linux";
    modules = [
      ./installer
      iso
      headless
    ];
    specialArgs = {inherit lib;};
  };

  # An air-gapped NixOS live media to deal with
  # sensitive tooling (e.g. Yubikey, GPG, etc.)
  # isolated from all networking
  airgap = mkNixosIso {
    inherit withSystem;
    hostname = "airgap";
    system = "x86_64-linux";
    modules = [
      ./airgap
      iso
    ];
    specialArgs = {inherit lib;};
  };
}
