{ ... }:

{
  networking = {
    domain = "localdomain";

    firewall = {
      # Allow HTTP and HTTPS traffic
      allowedTCPPorts = [
        80
        443
      ];
    };
  };
}
