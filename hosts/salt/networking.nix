{ ... }:

{
  networking = {
    domain = "localdomain";

    firewall = {
      allowedTCPPorts = [
        # nginx proxy manager
        80 # for http
        81 # for network development
        443 # for https
      ];
    };
  };
}
