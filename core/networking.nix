{ config
, pkgs
, ...
}:

{
  networking.extraHosts = ''
    # dev-ip
    127.0.0.1 jise.dev

    # ban-ip
    127.0.0.1 bilibili.com
    127.0.0.1 www.bilibili.com

    # extra-ip
  '';
}
