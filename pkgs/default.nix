{ pkgs ? import <nixpkgs> {}
, ...
}:

rec {
  degit-rs = pkgs.callPackage ./degit-rs {};
}
