{ inputs, ... }:

let
  vars = import ./vars.nix { inherit inputs; };
in

with inputs;
{
  flake.nixosModules = {
    chill = {
      imports = [
        ../modules
        ./chill

        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
      ];

      nixpkgs.overlays = [ chillcicada.overlays.default ];

      networking.hostName = "chill";

      home-manager.users.${vars.userName}.imports = [ self.homeModules.chill ];

      system.stateVersion = "25.11";
    };

    salt = {
      imports = [
        ../modules
        ./salt

        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
      ];

      networking.hostName = "salt";

      home-manager.users.${vars.userName}.imports = [ self.homeModules.salt ];

      system.stateVersion = "25.11";
    };
  };

  flake.homeModules = {
    chill = {
      imports = [
        ../home
        ./chill/home.nix

        stylix.homeModules.stylix
        zen-browser.homeModules.default
        vscode-server.homeModules.default
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
