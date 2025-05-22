{ pkgs, ... }:

{
  imports = map (name: ./${name}) (
    builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ])
  );

  services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

  home.packages =
    with pkgs;
    [
      hyprshot # screenshot
      snapshot # camera
      nautilus # file manager
    ]
    ++ (with nur.repos; [
      novel2430.wemeet-bin-bwrap-wayland-screenshare
    ]);
}
