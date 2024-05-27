{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;

  sty = config.modules.style;
in {
  options.modules.style = {
    fonts = {
      sizes = {
        desktop = mkOption {
          description = ''
            The font size used in window titles/bars/widgets elements of
            the desktop.
          '';
          type = types.ints.unsigned;
          default = 10;
        };

        applications = mkOption {
          description = ''
            The font size used by applications.
          '';
          type = types.ints.unsigned;
          default = 12;
        };

        terminal = mkOption {
          description = ''
            The font size for terminals/text editors.
          '';
          type = types.ints.unsigned;
          default = sty.fonts.sizes.applications;
        };

        popups = mkOption {
          description = ''
            The font size for notifications/popups and in general overlay
            elements of the desktop.
          '';
          type = types.ints.unsigned;
          default = sty.fonts.sizes.desktop;
        };
      };
    };
  };
}
