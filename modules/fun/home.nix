{ pkgs, ... }:

{
  home.packages =
    with pkgs;
    [
      qq
      zotero
      wechat-uos
      teamspeak5_client
    ]
    ++ (with nur.repos; [
      chillcicada.wpsoffice-cn
    ]);
}
