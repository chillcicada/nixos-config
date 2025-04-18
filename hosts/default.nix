{ inputs, ... }:

let
  vars = import ./vars.nix { inherit inputs; };
in
with inputs;
{
  flake.nixosModules = {
    chill = {
      imports = [
        ./chill

        nur.modules.nixos.default
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
      ];

      networking.hostName = "chill";

      system.stateVersion = "25.05";
    };

    salt = {
      imports = [
        ./salt

        nur.modules.nixos.default
        arion.nixosModules.arion
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
      ];

      networking.hostName = "salt";

      system.stateVersion = "24.11";
    };
  };

  flake.homeModules = {
    chill = {
      imports = [
        ../home

        ../modules/code/home.nix
        ../modules/gnome/home.nix
        ../modules/editor/home.nix
        ../modules/desktop/home.nix

        stylix.homeManagerModules.stylix
        zen-browser.homeModules.default
      ];

      home.stateVersion = "25.05";
    };

    salt = {
      imports = [
        ../home

        ../modules/code/home.nix
      ];

      home.stateVersion = "24.11";
    };
  };

  flake.nixosConfigurations.chill = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = { inherit inputs system vars; };
    modules = [ self.nixosModules.chill ];
  };

  flake.nixosConfigurations.salt = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = { inherit inputs system vars; };
    modules = [ self.nixosModules.salt ];
  };
}
