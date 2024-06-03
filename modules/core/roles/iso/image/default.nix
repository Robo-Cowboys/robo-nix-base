{
  self,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) cleanSource;
in {
  # the ISO image must be completely immutable in the sense that we do not
  # want the user to be able modify the ISO image after booting into it
  # the below option will disable rebuild switches (i.e nixos-rebuild switch)
  system.switch.enable = false;

  isoImage = {
    # maximum compression, in exchange for build speed
    squashfsCompression = "zstd -Xcompression-level 10"; # default uses gzip

    # ISO image should be an EFI-bootable volume
    makeEfiBootable = true;

    # ISO image should be bootable from USB
    # FIXME: the module description is as follows:
    # "Whether the ISO image should be bootable from CD as well as USB."
    # is this supposed to make the ISO image bootable from *CD* instead of USB?
    makeUsbBootable = true;

    contents = [
      {
        # my module system already contains an option to add memtest86+
        # to the boot menu at will but in case our system is unbootable
        # lets include memtest86+ in the ISO image
        # so that we may test the memory of the system
        # exclusively from the ISO image
        source = pkgs.memtest86plus + "/memtest.bin";
        target = "/boot/memtest.bin";
      }
      {
        # link this flake to /etc/nixos/flake so that the user can
        # can initiate a rebuild without having to clone and wait
        # useful if this installer is meant to be used on a system
        # that cannot access github
        source = cleanSource self;
        target = "/root/robo-nix";
      }
    ];
  };
}
