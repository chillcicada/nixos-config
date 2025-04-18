{ ... }:

{
  # Nixpkgs config
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
}
