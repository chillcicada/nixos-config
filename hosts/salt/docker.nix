{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arion
    docker-client
  ];

  virtualisation = {
    docker = {
      enable = true;
      liveRestore = false;
    };
    arion.backend = "docker";
  };

  environment.persistence."/persistent".directories = [ "/var/lib/docker" ];
}
