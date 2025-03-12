_:
let
  files = builtins.attrNames
    (removeAttrs (builtins.readDir ./.) [ "README.md" "default.nix" ]);
in { imports = map (name: ./${name}) files; }
