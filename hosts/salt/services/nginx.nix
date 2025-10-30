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

    virtualHosts."uptime.chillcicada.com" = {
      useACMEHost = "chillcicada.com";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
      };
    };

    virtualHosts."webdav.chillcicada.com" = {
      useACMEHost = "chillcicada.com";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8081";
        extraConfig = ''
          client_max_body_size 1024M;
        '';
      };
    };

    virtualHosts."pastebin.chillcicada.com" = {
      useACMEHost = "chillcicada.com";
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8082";
        extraConfig = ''
          client_max_body_size 1024M;
        '';
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = vars.userEmail;
    certs."chillcicada.com" = {
      domain = "chillcicada.com";
      extraDomainNames = [
        "uptime.chillcicada.com"
        "webdav.chillcicada.com"
        "pastebin.chillcicada.com"
      ];
    };
  };

  users.users.nginx.extraGroups = [ "acme" ];
}
