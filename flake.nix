{
  description = "chillcicada's personal nixos config on chill";

  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";

    nixos-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    nur.url = "github:nix-community/NUR";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.cc = import ./home.nix;
          home-manager.extraSpecialArgs = inputs;
        }
      ];
    };
  };
}
