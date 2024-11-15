_: let
  files = builtins.attrNames (removeAttrs (builtins.readDir ./.) [
    "README.md"
    "default.nix"
    "vscode.nix"
  ]);
in {
  imports = map (name: ./${name}) files;
}
