{ lib
, generateClientSrc
, rustPlatform
}:

{ specFile ? throw "specFile: no specification file was provided."
, cargoLock ? throw "cargoLock: no Cargo.lock file was provided."
, ...
}@args:

let
  src = generateClientSrc { inherit specFile; generatorName = "rust"; };
in
rustPlatform.buildRustPackage ({
  inherit (src)
    pname
    version;
  inherit src;

  cargoLock.lockFile = cargoLock;
  postPatch = "ln -s ${cargoLock} Cargo.lock";
} // (builtins.removeAttrs args [ "cargoLock" ]))
