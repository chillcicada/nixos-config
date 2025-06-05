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

      system.stateVersion = "25.11";
    };

    salt = {
      imports = [
        ./salt

        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
      ];

      networking.hostName = "salt";

      system.stateVersion = "25.11";
    };
  };

  flake.homeModules = {
    chill = {
      imports = [
        ./chill/home.nix

        ../home
        ../modules/code/home
        ../modules/editor/home
        ../modules/graphics/home
        ../modules/desktop/gnome/home
        # ../modules/desktop/hyprland/home

        stylix.homeModules.stylix
        zen-browser.homeModules.default
      ];

      home.stateVersion = "25.11";
    };

    salt = {
      imports = [ ../home/minimal.nix ];

      home.stateVersion = "25.11";
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
