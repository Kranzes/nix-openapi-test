{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts = { url = "github:hercules-ci/flake-parts"; inputs.nixpkgs-lib.follows = "nixpkgs"; };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];

      imports = [
        ./generators
      ];

      flake.herculesCI.ciSystems = [ "x86_64-linux" ];

      perSystem = { pkgs, config, ... }: {
        packages = {
          swagger-petstore-python = config.legacyPackages.buildPythonFromOpenapi {
            specFile = ./petstore.json;
            propagatedBuildInputs = with pkgs.python3.pkgs; [
              python-dateutil
              aenum
              pydantic
              urllib3
            ];
          };
          default = config.packages.swagger-petstore-python;
        };
      };
    };
}
