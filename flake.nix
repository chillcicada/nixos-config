{
  description = "chillcicada's personal nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    flake-parts.url = "github:hercules-ci/flake-parts";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.flake-parts.follows = "flake-parts";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";

    lxgw-fonts.url = "github:chillcicada/lxgw-fonts-flake";
    lxgw-fonts.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-server.inputs.flake-parts.follows = "flake-parts";

    chillcicada.url = "github:chillcicada/nurpkgs";
    chillcicada.inputs.nixpkgs.follows = "nixpkgs";

    nvim-config = {
      type = "github";
      owner = "chillcicada";
      repo = "nvim-config";
      flake = false;
    };

    typora-themes = {
      type = "github";
      owner = "chillcicada";
      repo = "typora-themes";
      flake = false;
    };
  };

  outputs =
    { flake-parts, ... }@inputs:

    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./hosts ];
      systems = [ "x86_64-linux" ];
    };
}
