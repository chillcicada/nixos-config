{ pkgs, ... }:

{
  services.gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;

  home.packages =
    with pkgs;
    [ ]
    ++ (with nur.repos; [
      novel2430.wemeet-bin-bwrap-wayland-screenshare
    ]);
}
