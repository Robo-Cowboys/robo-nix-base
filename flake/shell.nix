{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.pre-commit-hooks-nix.flakeModule

    inputs.just-flake.flakeModule
    ./shell/just/switch.nix
    ./shell/just/boot.nix
    ./shell/just/iso.nix
    ./shell/just/build.nix
    ./shell/just/test.nix
    ./shell/just/tree-fmt.nix #tree fmt command
  ];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    # Add your auto-formatters here.
    # cf. https://numtide.github.io/treefmt/
    treefmt.config = {
      flakeCheck = false; # pre-commit-hooks.nix checks this
      programs = {
        alejandra.enable = true;
        black.enable = true;
        deadnix.enable = true;
        statix = {
          enable = true;
          disabled-lints = [
            "manual_inherit_from"
          ];
        };
        mdformat.enable = true;
        taplo.enable = true;
        shfmt.enable = true;
        prettier.enable = true;
      };
    };

    devShells.default = pkgs.mkShell {
      inputsFrom = [
        config.treefmt.build.devShell
        config.just-flake.outputs.devShell
        config.pre-commit.devShell
      ];
      packages = [
        pkgs.caligula
      ];
    };
  };
}
