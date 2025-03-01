{ pkgs
, inputs
, config
, vars
, ...
}:

{
  # Nixpkgs config
  nixpkgs = {
    overlays = [
      inputs.nur.overlays.default
    ];
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;

      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };

      permittedInsecurePackages = [
        "electron-11.5.0"
      ];
    };
  };
}
