{
  perSystem = { pkgs, config, ... }: {
    packages = {
      # Python (python-nextgen)
      swagger-petstore-python = config.legacyPackages.buildPythonClientFromOpenapi {
        specFile = ./petstore.json;
        propagatedBuildInputs = with pkgs.python3.pkgs; [
          python-dateutil
          aenum
          pydantic
          urllib3
        ];
      };
      # Rust
      swagger-petstore-rust = config.legacyPackages.buildRustClientFromOpenapi {
        specFile = ./petstore.json;
        cargoLock = ./Cargo.lock;

        nativeBuildInputs = [ pkgs.pkg-config ];

        buildInputs = [ pkgs.openssl ];
      };
    };
  };
}
