{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # merecat
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
}
