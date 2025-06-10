{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    im.enable = lib.mkEnableOption "im";
  };

  config = lib.mkIf config.im.enable {
    home.packages = with pkgs; [
      qq
      wechat-uos
    ];
  };
}
