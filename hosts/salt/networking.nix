{ ... }:

{
  networking = {
    domain = "localdomain";

    firewall = {
      allowedTCPPorts = [
        80 # Nginx Services
        81 # Nginx Web Admin
        443 # Nginx Services (HTTPS)
      ];
      allowedUDPPorts = [
      ];
    };
  };
}
