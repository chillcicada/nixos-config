{
  description = "chillcicada's personal nixos config";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # my NUR
    chillcicada.url = "github:chillcicada/nurpkgs";
    chillcicada.inputs.nixpkgs.follows = "nixpkgs";

    # my neovim config
    nvim-config = {
      type = "github";
      owner = "chillcicada";
      repo = "nvim-config";
      flake = false;
    };

    # my typora themes
    typora-themes = {
      type = "github";
      owner = "chillcicada";
      repo = "typora-themes";
      flake = false;
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:

    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./hosts ];
      systems = [ "x86_64-linux" ];
    };
}
