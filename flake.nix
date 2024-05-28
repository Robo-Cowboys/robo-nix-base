{
  description = "Robo Squad monorepo for everything NixOS";

  outputs = inputs:
    inputs.robo-nix-lib.mkRoboFlake {
      # You must provide our flake inputs to Robo Nix Lib.
      inherit inputs;

      # The `src` must be the root of the flake. See configuration
      # in the next section for information on how you can move your
      # Nix files to a separate directory.
      src = ./.;
    };

  inputs = {
    # global, so they can be `.follow`ed
    systems.url = "github:nix-systems/default-linux";

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

    #Also by...
    robo-nix-modules = {
      url = "github:Robo-Cowboys/modules";
      #      url = "path:/home/sincore/source/RoboNyx-template/robo-nyx";
    };

    robo-nix-lib = {
      url = "github:Robo-Cowboys/lib";
      #      url = "path:/home/sincore/source/robo-lib";
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

    #Devshell conviance commands
    just-flake.url = "github:juspay/just-flake";

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

    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
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

    # A collection of utilities to generate nixos images in other formats. With this tool, we can easily customize our USB image.
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland & Hyprland Contrib repos
    # to be able to use the binary cache, we should avoid
    # overriding the nixpkgs input - as the resulting hash would
    # mismatch if packages are builst against different versions
    # of the same depended packagaes
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.39.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
