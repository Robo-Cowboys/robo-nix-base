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
  hm = inputs.home-manager.nixosModules.home-manager; # home-manager nixos module

  # serializing the modulePath to a variable
  # this is in case the modulePath changes depth (i.e modules becomes nixos/modules)
  modulePath = "${inputs.nyx}/modules";

  coreModules = "${modulePath}/nixos"; # the path where common modules reside
  #  extraModules = modulePath + /extra; # the path where extra modules reside
  options = "${modulePath}/options"; # the module that provides the options for my system configuration

  # common modules
  # to be shared across all systems without exception
  common = "${coreModules}/common"; # the self-proclaimed sane defaults for all my systems
  profiles = "${coreModules}/profiles"; # force defaults based on selected profile

  # roles
  iso = "${coreModules}/roles/iso"; # for providing a uniform ISO configuration for live systems - only the build setup
  headless = "${coreModules}/roles/headless"; # for devices that are of the headless type - provides no GUI
  graphical = "${coreModules}/roles/graphical"; # for devices that are of the graphical type - provides a GUI
  workstation = "${coreModules}/roles/workstation"; # for devices that are of workstation type - any device that is for daily use
  server = "${coreModules}/roles/server"; # for devices that are of the server type - provides online services
  laptop = "${coreModules}/roles/laptop"; # for devices that are of the laptop type - provides power optimizations

  # home-manager #
  #  homesDir = ../homes; # home-manager configurations for hosts that need home-manager
  #  homes = [hm homesDir]; # combine hm flake input and the home module to be imported together

  # a list of shared modules that ALL systems need
  shared = [
    common # the "sane" default shared across systems
    options # provide options for defined modules across the system
    sops-nix # age encryption for secrets
    profiles # profiles program overrides per-host
  ];
in {
  #  # My main desktop boasting a RX 6700XT and a Ryzen 5 3600x
  #  # fully free from nvidia
  #  # fuck nvidia - Linus "the linux" Torvalds
  #  enyo = mkNixosSystem {
  #    inherit withSystem;
  #    hostname = "enyo";
  #    system = "x86_64-linux";
  #    modules =
  #      [
  #        ./enyo
  #        graphical
  #        workstation
  #      ]
  #      ++ concatLists [shared homes];
  #    specialArgs = {inherit lib;};
  #  };
  #  # Lenovo Ideapad from 2014..
  #  # Hybrid device
  #  # acts as a portable server and a "workstation"
  #  icarus = mkNixosSystem {
  #    inherit withSystem;
  #    hostname = "icarus";
  #    system = "x86_64-linux";
  #    modules =
  #      [
  #        ./icarus
  #        graphical
  #        workstation
  #        laptop
  #        server
  #      ]
  #      ++ concatLists [shared homes];
  #    specialArgs = {inherit lib;};
  #  };
  #
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
