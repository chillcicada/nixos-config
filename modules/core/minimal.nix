{
  pkgs,
  lib,
  vars,
  inputs,
  ...
}:

{
  imports = [
    ./system.nix
  ];

  # nix
  nix = {
    package = pkgs.nix;
    channel.enable = false;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ vars.userName ];
    };
  };

  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

  # locales
  time.timeZone = "Asia/Shanghai";

  # fonts
  fonts.fontconfig.enable = false;
}
