{ ... }:

{
  networking = {
    domain = "localdomain";

    firewall = {
      allowedTCPPorts = [
        80 # for http
        81 # for network development
        443 # for https

        30033 # for teamspeak_filetransfer
      ];
      allowedUDPPorts = [
        9987 # for teamspeak_voice
        10011 # for teamspeak_serverquery
      ];
    };
  };
}
