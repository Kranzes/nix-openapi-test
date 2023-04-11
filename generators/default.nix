{
  perSystem = { pkgs, ... }: {
    legacyPackages = rec {
      generateClientSrc = pkgs.callPackage ./generateClientSrc.nix { };
      buildPythonClientFromOpenapi = pkgs.callPackage ./python.nix { inherit generateClientSrc; };
      buildRustClientFromOpenapi = pkgs.callPackage ./rust.nix { inherit generateClientSrc; };
    };
  };
}
