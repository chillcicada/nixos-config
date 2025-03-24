{ inputs, ... }:
let
  vars = {
    userName = "cc";
    userFullname = "chillcicada";
    userEmail = "2210227279@qq.com";
  };
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

        catppuccin.homeManagerModules.catppuccin
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
