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
    };
  };

  flake.homeModules = {
    chill = {
      # gnome
      imports = [
        ../home

        ../modules/gnome/home.nix

        stylix.homeManagerModules.stylix
      ];
    };
  };

  flake.nixosConfigurations.chill = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = { inherit inputs system vars; };
    modules = [ self.nixosModules.chill ];
  };
}
