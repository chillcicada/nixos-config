{ lib, vars, ... }:

{
  # Nixpkgs config
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;

      permittedInsecurePackages = [ "electron-11.5.0" ];
    };

    hostPlatform = lib.mkDefault vars.hostPlatform;
  };

}
