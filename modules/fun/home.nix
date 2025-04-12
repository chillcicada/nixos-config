{ pkgs, ... }:

{
  imports = [ ./home ];

  home.packages =
    with pkgs;
    [
      qq
      typora
      kazumi
      zotero
      wechat-uos
      cherry-studio
      teamspeak5_client
    ]
    ++ (with nur.repos; [
      chillcicada.wpsoffice-cn
    ]);
}
