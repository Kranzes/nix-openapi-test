{ lib
, runCommand
, openapi-generator-cli
}:

{ specFile ? throw "specFile: no specification file was provided."
, generatorName ? throw "generatorName: no generator name was provided."
}:

let
  # Metadata
  inherit (lib.importJSON specFile) info;
  inherit (info) version;
  pname = lib.toLower (builtins.replaceStrings [ " " ] [ "_" ] info.title);
in
runCommand "${pname}-${generatorName}-src" { nativeBuildInputs = [ openapi-generator-cli ]; passthru = { inherit version pname info; }; } ''
  openapi-generator-cli generate \
    --input-spec ${specFile} \
    --output "$out" \
    --generator-name ${generatorName} \
    --package-name ${pname} \
    --enable-post-process-file
''
