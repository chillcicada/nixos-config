{ ... }:

{
  # Nixpkgs config
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;

      permittedInsecurePackages = [ "electron-11.5.0" ];
    };
  };
}
