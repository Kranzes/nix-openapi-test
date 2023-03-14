{ lib
, python3
, runCommand
, openapi-generator-cli
}:

{ specFile ? throw "specFile: no specification file was provided."
, ...
}@args:

let
  # Metadata
  inherit (lib.importJSON specFile) info;
  inherit (info) version;
  pname = lib.toLower (builtins.replaceStrings [ " " ] [ "_" ] info.title);

  # Generated source code
  src = runCommand "${pname}-src" { nativeBuildInputs = [ openapi-generator-cli ]; } ''
    openapi-generator-cli generate \
      --input-spec ${specFile} \
      --output "$out" \
      --generator-name python-nextgen \
      --package-name ${pname} \
      --enable-post-process-file
  '';
in
python3.pkgs.buildPythonPackage ({
  inherit
    pname
    version
    src;

  pythonImportsCheck = [ pname ];
} // args)
