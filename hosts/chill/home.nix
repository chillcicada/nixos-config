{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hmcl
    kazumi
    aseprite
    obs-studio
    teamspeak5_client
    nur.repos.novel2430.wemeet-bin-bwrap-wayland-screenshare
  ];

  services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

  # self defined options
  coreutils.enable = true;
  tools.enable = true;
  graphics.enable = true;
  fcitx5.enable = true;

  cpp.enable = true;
  frontend.enable = true;
  nixlang.enable = true;
  python.enable = true;
  typst.enable = true;

  vscode.enable = true;
  neovim.enable = true;

  im.enable = true;
  office.enable = true;
}
