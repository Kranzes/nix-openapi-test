{
  perSystem = { pkgs, ... }: {
    legacyPackages = {
      buildPythonFromOpenapi = pkgs.callPackage ./python.nix { };
    };
  };
}
