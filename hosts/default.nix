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

        home-manager.nixosModules.home-manager
      ];

      networking.hostName = "salt";

      system.stateVersion = "25.05";
    };
  };

  flake.homeModules = {
    chill = {
      imports = [
        ../home

        ../modules/code/home.nix
        ../modules/games/home.nix
        ../modules/editor/home.nix
        ../modules/graphics/home.nix
        ../modules/desktop/gnome/home.nix
        # ../modules/desktop/hyprland/home.nix

        stylix.homeManagerModules.stylix
        zen-browser.homeModules.default
      ];

      home.stateVersion = "25.05";
    };

    salt = {
      imports = [
        ../home/minimal.nix
      ];

      home.stateVersion = "25.05";
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
