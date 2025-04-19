{ ... }:

{
  networking = {
    domain = "localdomain";

    firewall = {
      allowedTCPPorts = [
        80 # Nginx Services
        81 # Nginx Web Admin
        443 # Nginx Services (HTTPS)
        7791 # lsky-pro
        8080 # webdav
      ];
      allowedUDPPorts = [
      ];
    };
  };
}
