{ ... }:

{
  imports = [
    ./steam.nix
  ];

  programs.clash-verge = {
    enable = true;
    autoStart = true;
  };
}
