{ lib
, generateClientSrc
, python3
}:

{ specFile ? throw "specFile: no specification file was provided."
, ...
}@args:

let
  src = generateClientSrc { inherit specFile; generatorName = "python-nextgen"; };
in
python3.pkgs.buildPythonPackage (rec {
  inherit (src)
    pname
    version;
  inherit src;

  pythonImportsCheck = [ pname ];
} // args)
