{
  description = "chillcicada's personal nixos config";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # my NUR repo
    chillcicada.url = "github:chillcicada/nurpkgs";

    # my wallpaper repo
    imgs.url = "github:chillcicada/imgs";

    # my neovim config
    nvim-config = {
      type = "github";
      owner = "chillcicada";
      repo = "nvim-config";
      flake = false;
    };

    # my typora themes repo
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
