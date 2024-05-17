{
  description = "Robo Squad monorepo for everything NixOS";

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      # systems for which the attributes of `perSystem` will be built
      # and more if they can be supported...
      #  - x86_64-linux: Desktops, laptops, servers
      #  - aarch64-linux: ARM-based devices, PoC server and builders
      systems = import inputs.systems;

      # import parts of the flake, which allows me to build the final flake
      # from various parts constructed in a way that makes sense to me
      # the most
      imports = [
        # parts and modules from inputs
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.treefmt-nix.flakeModule

        # parts of the flake
        #        ./nyx/flake/apps # apps provided by the flake
        #        ./flake/checks # checks that are performed on `nix flake check`
        "${inputs.nyx}/flake/lib" # extended library on top of `nixpkgs.lib`
        "${inputs.nyx}/flake/modules" # nixos and home-manager modules provided by this flake
        #        ./flake/pkgs # packages exposed by the flake
        "${inputs.nyx}/flake/pre-commit" # pre-commit hooks, performed before each commit inside the devShell
        #        ./flake/templates # flake templates

        ./flake/keys.nix
        "${inputs.nyx}/flake/args.nix" # args that are passed to the flake, moved away from the main file
        #        ./flake/deployments.nix # deploy-rs configurations for active hosts
        "${inputs.nyx}/flake/fmt.nix" # various formatter configurations for this flake
        "${inputs.nyx}/flake/iso-images.nix" # local installation media
        "${inputs.nyx}/flake/shell.nix" # devShells exposed by the flake
      ];

      flake = {
        # entry-point for NixOS configurations
        nixosConfigurations = import ./hosts {inherit inputs withSystem;};
      };
    });

  inputs = {
    # global, so they can be `.follow`ed
    systems.url = "github:nix-systems/default-linux";

    # Feature-rich and convenient fork of the Nix package manager
    nix-super.url = "github:privatevoid-net/nix-super";

    # We build against nixos unstable, because stable takes way too long to get things into
    # more versions with or without pinned branches can be added if deemed necessary
    # stable? never heard of her
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # sometimes nixpkgs breaks something I need, pin a working commit when that occurs
    # nixpkgs-pinned.url = "github:NixOS/nixpkgs/b610c60e23e0583cdc1997c54badfd32592d3d3e";

    # Powered by
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nyx = {
      flake = false;
      url = "path:/home/sincore/source/nyx-snowfall-template/nyx";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager?main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Shhhhhhh it's a secret.
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Ever wanted nix error messages to be even more cryptic?
    # Try flake-utils today! (Devs I beg you please stop)
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    # Repo for hardware-specific NixOS modules
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Nix wrapper for building and testing my system
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # multi-profile Nix-flake deploy
    deploy-rs.url = "github:serokell/deploy-rs";

    # A tree-wide formatter
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixfmt = {
      url = "github:nixos/nixfmt";
      flake = false;
    };

    # Project shells
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # guess what this does
    # come on, try
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        #        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };

    # sandbox wrappers for programs
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    # This exists, I guess
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    # Impermanence
    # doesn't offer much above properly used symlinks
    # but it *is* convenient
    impermanence.url = "github:nix-community/impermanence";

    # Secure-boot support on nixos
    # the interface iss still shaky and I would recommend
    # avoiding on production systems for now
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };

    # Personal package overlay
    nyxpkgs.url = "github:NotAShelf/nyxpkgs";

    # use my own wallpapers repository to provide various wallpapers as nix packages
    wallpkgs = {
      url = "github:use-the-fork/wallpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Handy for managing FS
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spicetify for theming spotify
    spicetify = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland & Hyprland Contrib repos
    # to be able to use the binary cache, we should avoid
    # overriding the nixpkgs input - as the resulting hash would
    # mismatch if packages are builst against different versions
    # of the same depended packagaes
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://nyx.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nyx.cachix.org-1:xH6G0MO9PrpeGe7mHBtj1WbNzmnXr7jId2mCiq6hipE="
    ];
  };
}
