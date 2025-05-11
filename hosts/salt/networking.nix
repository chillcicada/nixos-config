{ ... }:

{
  networking = {
    domain = "localdomain";

    firewall = {
      allowedTCPPorts = [
        80 # for http
        81 # for network development
        443 # for https
      ];
    };
  };
}
