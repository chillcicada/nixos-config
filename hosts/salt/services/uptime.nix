{ ... }:

{
  services.uptime-kuma = {
    enable = true;

    # https://github.com/louislam/uptime-kuma/wiki/Environment-Variables
    settings = {
      HOST = "127.0.0.1";
      PORT = "8081";
    };
  };
}
