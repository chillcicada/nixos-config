{ pkgs, ... }:

{
  imports = [ ./home ];

  home.packages =
    with pkgs;
    [
      qq
      kazumi
      zotero
      wechat-uos
      teamspeak5_client
    ]
    ++ (with nur.repos; [
      chillcicada.wpsoffice-cn
    ]);
}
