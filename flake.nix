{
  description = "chillcicada's personal nixos config on chill";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    systems.url = "github:nix-systems/default-linux";

    hyprland.url = "github:hyprwm/Hyprland";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    stylix.url = "github:danth/stylix";

    sops-nix.url = "github:Mic92/sops-nix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs: import ./outputs inputs;
}
