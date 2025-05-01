{ pkgs, ... }:

{
  imports = [ ./home ];

  services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

  home.packages =
    with pkgs;
    [
      nautilus # file manager
    ]
    ++ (with nur.repos; [
      novel2430.wemeet-bin-bwrap-wayland-screenshare
    ]);
}
