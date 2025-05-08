{ vars, ... }:

{
  # https://wiki.nixos.org/wiki/Nginx
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."webdav.chillcicada.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://0.0.0.0:8080";
        proxyWebsockets = true; # needed if you need to use WebSocket
        extraConfig =
          # required when the target is also TLS server with multiple hosts
          "proxy_ssl_server_name on;";
      };
    };
    virtualHosts."img.chillcicada.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://0.0.0.0:7791";
        proxyWebsockets = true; # needed if you need to use WebSocket
        extraConfig =
          # required when the target is also TLS server with multiple hosts
          "proxy_ssl_server_name on;";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = vars.userEmail;
  };
}
