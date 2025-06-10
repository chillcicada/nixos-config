{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = map (name: ./${name}) (
    builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ])
  );

  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      hyprshot # screenshot
      hyprcursor
      snapshot # camera
      nautilus # file manager
    ];
  };
}
