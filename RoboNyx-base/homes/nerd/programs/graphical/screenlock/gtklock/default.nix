_: {
  #  config = mkIf env.programs.screenlock.gtklock.enable {
  #    programs.gtklock = {
  #      enable = true;
  #      package = pkgs.gtklock;
  #
  #      config = {
  #        modules = [
  #          "${pkgs.gtklock-powerbar-module.outPath}/lib/gtklock/powerbar-module.so"
  #        ];
  #
  #        style = builtins.readFile (lib.compileSCSS pkgs {
  #          name = "gtklock-dark";
  #          path = ./styles/dark.scss;
  #        });
  #      };
  #
  #      extraConfig = {};
  #    };
  #  };
}
