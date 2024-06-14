{
  inputs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) mkIf forEach;

  sys = osConfig.modules.system;
  cfg = osConfig.modules.system.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  config = mkIf cfg.enable {
    home.persistence."/persistent/home/${sys.mainUser}" = {
      directories =
        [
          "Downloads"
          "Music"
          "Games"
          "Pictures"
          "Documents"
          "Videos"
          "source"
          ".gnupg"
          ".ssh"
          ".keepass"
          ".local/share/keyrings"
          ".var/app"
        ]
        #TODO This should be centrilized as well.
        ++ forEach ["google-chrome" "orca-slicer" "flatpak"] (x: ".cache/${x}")
        ++ forEach ["direnv" "flatpak"] (x: ".local/share/${x}")
        ++ forEach ["dots" "NordPass" "Signal" "OrcaSlicer" "PrusaSlicer" "JetBrains" "google-chrome" "sops"] (x: ".config/${x}");
      files = [
        ".git-credentials"
      ];
      allowOther = true;
    };
  };
}
