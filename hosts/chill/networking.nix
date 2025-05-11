{ lib, ... }:

{
  services.openssh.ports = [
    22
    20202
  ];

  networking = {
    networkmanager = {
      enable = true;
    };

    useDHCP = lib.mkDefault true;

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
