{ ... }:

{
  services.openssh.ports = [
    22
    20202 # the lower ports is gotten blocked by the THU
  ];

  networking = {
    networkmanager.enable = true;

    firewall = {
      enable = true;
      # Allow HTTP and SSH traffic
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedTCPPortRanges = [
        {
          from = 2000;
          to = 65535;
        }
      ];
      allowedUDPPorts = [ ];
      allowedUDPPortRanges = [
        {
          from = 2000;
          to = 65535;
        }
      ];
    };
  };
}
