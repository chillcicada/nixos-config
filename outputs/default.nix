{ self, nixpkgs, home-manager, ... } @ inputs: let
  inherit (self) outputs;
  inherit (inputs.nixpkgs) lib;

  vars = import ../vars.nix { inherit lib; };
in {
  overlays = import ../overlays { inherit inputs; };

  nixosConfigurations.${vars.hostName} = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs lib vars; };
    system = "x86_64-linux";
    modules = [
      ../configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.extraSpecialArgs = { inherit inputs vars; };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.cc = import ../home.nix;
        home-manager.backupFileExtension = "backup";
      }
    ];
  };
}
