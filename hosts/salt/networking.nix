{ ... }:

{
  networking = {
    domain = "localdomain";

    firewall = {
      allowedTCPPorts = [
        # nginx proxy manager
        80 # for http
        81 # web panel
        443 # for https

        # lsky-pro
        7791

        # webdav
        8080

        # teamspeak
        10011 # server query
        30033 # file transfer
      ];
      allowedUDPPorts = [
        # teamspeak
        9987 # voice
      ];
    };
  };
}
