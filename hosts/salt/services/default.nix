_:
let
  files = builtins.attrNames (
    removeAttrs (builtins.readDir ./.) [
      "default.nix"
      "webdav.nix"
    ]
  );
in
{
  imports = map (name: ./${name}) files;
}
