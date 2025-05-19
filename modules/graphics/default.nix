{ ... }:

{
  programs.clash-verge = {
    enable = true;
    /*
      https://github.com/NixOS/nixpkgs/issues/408632
    */
    # autoStart = true;
  };
}
