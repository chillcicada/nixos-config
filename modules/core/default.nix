_:
let
  files = builtins.attrNames (
    removeAttrs (builtins.readDir ./.) [
      "default.nix"
      "minimal.nix"
    ]
  );
in
{
  imports = map (name: ./${name}) files;
}
