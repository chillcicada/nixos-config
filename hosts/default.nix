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
        hjem.nixosModules.default
        vscode-server.nixosModules.default
        stylix.nixosModules.stylix
      ];

      networking.hostName = "chill";
      hjem.users.${vars.userName}.imports = [
        ../home
        ./chill/home.nix
      ];
      system.stateVersion = "26.11";
    };

    salt = {
      imports = [
        ../modules
        ./salt

        sops-nix.nixosModules.sops
        hjem.nixosModules.default
      ];

      networking.hostName = "salt";
      hjem.users.${vars.userName}.imports = [ ../home/common.nix ];
      system.stateVersion = "26.11";
    };
  };

  flake.nixosConfigurations.chill = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs system vars; };
    modules = [ self.nixosModules.chill ];
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [
        lxgw-fonts.overlays.default
        chillcicada.overlays.default
      ];
    };
  };

  flake.nixosConfigurations.salt = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs system vars; };
    modules = [ self.nixosModules.salt ];
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  };
}
