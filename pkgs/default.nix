{ pkgs ? import <nixpkgs> {}
, ...
}:

rec {
  degit = pkgs.callPackage ./degit {};
}
