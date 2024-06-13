{
  description = "OrcaSlicer flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {nixpkgs}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    packages.${system} = pkgs.stdenv.mkDerivation {
      pname = "orca-slicer";
      version = "1.0.0";

      src = pkgs.fetchFromGitHub {
        owner = "SoftFever";
        repo = "OrcaSlicer";
        rev = "main";
        sha256 = "aa692b815ea01e84d93c88a8467c6ebdfa5615c9";
      };

      nativeBuildInputs = [pkgs.cmake pkgs.git pkgs.strawberry-perl];

      buildInputs = [pkgs.gcc];

      buildPhase = ''
        mkdir -p build
        cd build
        cmake .. -DCMAKE_BUILD_TYPE=Release
      '';

      installPhase = ''
        make install
      '';
    };
  };
}
