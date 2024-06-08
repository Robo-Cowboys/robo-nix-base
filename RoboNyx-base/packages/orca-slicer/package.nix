{
  lib,
  appimageTools,
  fetchurl,
  makeDesktopItem,
}: let
  pname = "orca-slicer";
  version = "2.0.0";
  sha256 = "PcCsqF1RKdSrbdp1jCF0n5Mu30EniaBEuJNw3XdPhO4="; # Taken from release's checksums.txt.gpg
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/SoftFever/OrcaSlicer/releases/download/v${version}/OrcaSlicer_Linux_V${version}.AppImage";
    inherit sha256;
  };

  appimageContents = appimageTools.extractType2 {
    inherit name src;
  };

  desktopItem = makeDesktopItem {
    name = pname;
    desktopName = pname;
    comment = "G-code generator for 3d printers";
    exec = pname;
    icon = "OrcaSlicer";
    mimeTypes = ["model/stl" "application/vnd.ms-3mfdocument" "application/prs.wavefront-obj" "application/x-amf"];
    categories = ["Utility"];
  };
in
  appimageTools.wrapType2 rec {
    inherit name src;

    #    multiArch = false; # no p32bit needed
    extraPkgs = pkgs:
      (appimageTools.defaultFhsEnvArgs.multiPkgs pkgs)
      ++ (with pkgs; [
        webkitgtk
        glib
        glib-networking
      ]);

    extraInstallCommands = ''
      mv $out/bin/{${name},${pname}}

      mkdir -p $out/share
      cp -rt $out/share ${desktopItem}/share/applications ${appimageContents}/usr/share/icons
      chmod -R +w $out/share
    '';

    meta = with lib; {
      description = "G-code generator for 3d printers";
      platforms = ["x86_64-linux"];
      maintainers = [];
      mainProgram = "OrcaSlicer";
    };
  }
