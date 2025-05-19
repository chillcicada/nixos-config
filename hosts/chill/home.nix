{ pkgs, ... }:

{
  home.packages =
    with pkgs;
    [
      qq
      hmcl
      kazumi
      zotero
      obs-studio
      wechat-uos
      libresprite
      teamspeak5_client
    ]
    ++ (with nur.repos; [
      chillcicada.wpsoffice-cn
    ]);
}
