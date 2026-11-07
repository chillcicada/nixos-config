{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.hyprland;
in

{
  imports = map (name: ./${name}) (
    builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ])
  );

  options.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf cfg.enable {
    packages = with pkgs; [
      hyprshot # screenshot
      hyprcursor
      snapshot # camera
      nautilus # file manager
    ];
  };
}
