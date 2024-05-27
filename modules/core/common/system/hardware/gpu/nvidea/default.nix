{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkMerge;

  # use the latest possible nvidia package

  dev = config.modules.device;
in {
  config = mkIf (builtins.elem dev.gpu.type ["nvidia" "hybrid-nv"]) {
    # nvidia drivers are unfree software
    nixpkgs.config.allowUnfree = true;

    services.xserver = mkMerge [
      {
        videoDrivers = ["nvidia"];
      }
    ];

    environment = {
      sessionVariables = mkMerge [
        {LIBVA_DRIVER_NAME = "nvidia";}

        #        (mkIf env.isWayland {
        {WLR_NO_HARDWARE_CURSORS = "1";}
        #        })
      ];

      #TODO: Pete do you need any of these.
      systemPackages = with pkgs; [
        #        nvtopPackages.nvidia
        #
        #        # mesa
        #        mesa
        #
        #        # vulkan
        #        vulkan-tools
        #        vulkan-loader
        #        vulkan-validation-layers
        #        vulkan-extension-layer
        #
        #        # libva
        #        libva
        #        libva-utils
      ];
    };

    hardware = {
      nvidia = {
        prime = {
          offload = {
            enable = lib.mkOverride 990 true;
            enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true; # Provides `nvidia-offload` command.
          };
          intelBusId = "PCI:8:0:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };

      opengl = {
        extraPackages = with pkgs; [vaapiVdpau];
      };
    };
  };
}
