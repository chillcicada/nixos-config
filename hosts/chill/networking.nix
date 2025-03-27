{ lib, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
    };

    useDHCP = lib.mkDefault true;

    extraHosts = ''
      # extra-ip

      # dev-ip
      127.0.0.1 jise.dev

      # ban-ip
      127.0.0.1 bilibili.com
      127.0.0.1 www.bilibili.com
    '';

    firewall = {
      enable = true;
      # Allow HTTP and SSH traffic
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPorts = [ ];
    };
  };
}
