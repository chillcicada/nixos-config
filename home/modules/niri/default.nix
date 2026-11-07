{
  pkgs,
  lib,
  osConfig,
  ...
}:

let
  cfg = osConfig.desktop;
in

{
  imports = map (name: ./${name}) (
    builtins.attrNames (
      lib.filterAttrs (
        name: type: name != "default.nix" && (type == "directory" || lib.hasSuffix ".nix" name)
      ) (builtins.readDir ./.)
    )
  );

  config = lib.mkIf (cfg.enable && cfg.wm == "niri") {
    packages = with pkgs; [
      nautilus # file manager
      snapshot # camera
      xwayland-satellite # X11 app support
    ];
  };
}
