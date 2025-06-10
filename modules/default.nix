_: {
  imports = map (name: ./${name}) (
    builtins.attrNames (
      removeAttrs (builtins.readDir ./.) [
        "core"
        "default.nix"
      ]
    )
  );
}
