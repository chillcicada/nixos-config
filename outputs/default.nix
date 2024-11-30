{ self
, nixpkgs
, home-manager
, systems
, catppuccin
, stylix
, sops-nix
, ...
} @ inputs:

let
  inherit (self) outputs;
  inherit (inputs.nixpkgs) lib;

  forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
  pkgsFor = lib.genAttrs (import systems) (
    system:
    import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    }
  );

  vars = import ../vars.nix { inherit lib; };
in
{
  overlays = import ../overlays { inherit inputs; };

  nixosConfigurations.${vars.hostName} = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs lib vars; };
    system = "x86_64-linux";
    modules = [
      ../configuration.nix

      sops-nix.nixosModules.sops

      home-manager.nixosModules.home-manager
      {
        home-manager.extraSpecialArgs = { inherit inputs vars; };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.cc = {
          imports = [
            ../home.nix
            catppuccin.homeManagerModules.catppuccin
            stylix.homeManagerModules.stylix
          ];
        };
        home-manager.backupFileExtension = "backup";
      }
    ];
  };
}
