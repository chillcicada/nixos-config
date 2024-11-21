{
  description = "chillcicada's personal nixos config on chill";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    nixpkgs-master.url = "github:Nixos/nixpkgs/master";

    systems.url = "github:nix-systems/default-linux";

    nur.url = "github:nix-community/NUR";

    catppuccin.url = "github:catppuccin/nix";

    # FIXME: https://github.com/danth/stylix/issues/642
    stylix.url = "github:danth/stylix";
    stylix.inputs.base16.follows = "base16";
    base16.url = "github:Noodlez1232/base16.nix/slugify-fix";

    sops-nix.url = "github:Mic92/sops-nix";

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
