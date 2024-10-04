{ self, nixpkgs, home-manager, ... } @ inputs: let
  inherit (inputs.nixpkgs) lib;

  vars = import ../vars.nix { inherit lib; };
in {
  nixosConfigurations.${vars.hostName} = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs lib vars; };
    system = "x86_64-linux";
    modules = [
      ../configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.extraSpecialArgs = { inherit inputs vars; };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.cc = import ../home.nix;
      }
    ];
  };
}
