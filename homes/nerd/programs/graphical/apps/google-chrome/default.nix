{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.lists) optionals;
  inherit (osConfig) modules;
  sys = modules.system;
  prg = sys.programs;
in {
  config = mkIf prg.google-chrome.enable {
    programs.google-chrome = {
      enable = true;
      package = pkgs.google-chrome;
      commandLineArgs = optionals (lib.isWayland osConfig) [
        # Wayland

        # Disabled because hardware acceleration doesn't work
        # when disabling --use-gl=egl, it's not gonna show any emoji
        # and it's gonna be slow as hell
        # "--use-gl=egl"

        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform"
      ];
    };

    xdg = {
      desktopEntries."google-chrome-dark" = {
        name = "Google Chrome Dark";
        comment = "Access the Internet in Dark Mode";
        icon = "google-chrome";
        exec = "${pkgs.google-chrome}/bin/google-chrome-stable --enable-features=WebContentsForceDark";
        categories = ["Network" "WebBrowser"];
        terminal = false;
        mimeType = ["application/pdf" "application/rdf+xml" "application/rss+xml" "application/xhtml+xml" "application/xhtml_xml" "application/xml" "image/gif" "image/jpeg" "image/png" "image/webp" "text/html" "text/xml" "x-scheme-handler/http" "x-scheme-handler/https"];
      };
    };
  };
}
