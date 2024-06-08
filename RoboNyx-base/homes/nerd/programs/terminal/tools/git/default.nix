{
  pkgs,
  osConfig,
  ...
}: let
  git = osConfig.modules.system.programs.git;
in {
  imports = [
    ./ignore.nix
  ];

  config = {
    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;

      userName = git.userName;
      userEmail = git.userEmail;

      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "store";

        core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        color.ui = "auto";
      };
    };

    home.packages = [pkgs.gh];
  };
}
