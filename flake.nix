{
  description = "chillcicada's personal nixos config on chill";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    nixpkgs-master.url = "github:Nixos/nixpkgs/master";

    systems.url = "github:nix-systems/default-linux";

    nur.url = "github:nix-community/NUR";

    catppuccin.url = "github:catppuccin/nix";

    stylix.url = "github:danth/stylix";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs: import ./outputs inputs;
}
