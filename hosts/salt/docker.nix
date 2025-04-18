{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      daemon.settings = {
        "registry-mirrors" = [
          "https://docker.1ms.run"
          "https://docker.xuanyuan.me"
        ];
      };
    };
    oci-containers.backend = "docker";
  };
}
