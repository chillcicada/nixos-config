{ vars, ... }:

{
  # https://wiki.nixos.org/wiki/Nginx
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."chillcicada.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        return = "200 '<html><body>Hello world!</body></html>'";
        extraConfig = ''
          default_type text/html;
        '';
      };
    };

    virtualHosts."webdav.chillcicada.com" = {
      useACMEHost = "chillcicada.com";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
        extraConfig = ''
          client_max_body_size 1024M;
        '';
      };
    };

    virtualHosts."status.chillcicada.com" = {
      useACMEHost = "chillcicada.com";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8081";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = vars.userEmail;
    certs."chillcicada.com" = {
      domain = "chillcicada.com";
      extraDomainNames = [
        "webdav.chillcicada.com"
        "status.chillcicada.com"
      ];
    };
  };

  users.users.nginx.extraGroups = [ "acme" ];
}
