_: {
  imports = map (name: ./${name}) (
    builtins.attrNames (
      removeAttrs (builtins.readDir ./.) [
        "default.nix"
        "minimal.nix"
      ]
    )
  );
}
