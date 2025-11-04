{ vars, config, ... }:

let
  domainName = "chillcicada.com";

  proxyServices = [
    {
      prefix = "uptime";
      port = 8080;
    }
    {
      prefix = "webdav";
      port = 8081;
      extraConfig = ''
        client_max_body_size 1024M;
      '';
    }
    {
      prefix = "pastebin";
      port = 8082;
      extraConfig = ''
        client_max_body_size 1024M;
      '';
    }
  ];
in

{
  # https://wiki.nixos.org/wiki/Nginx
  services.nginx = {
    enable = true;

    recommendedTlsSettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;

    virtualHosts = {
      "${domainName}" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          return = "200 '<html><body>Hello world!</body></html>'";
          extraConfig = ''
            default_type text/html;
          '';
        };
      };
    }
    // (builtins.listToAttrs (
      map (service: {
        name = service.prefix + "." + domainName;
        value = {
          useACMEHost = domainName;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:${toString service.port}";
            extraConfig = service.extraConfig or "";
          };
        };
      }) proxyServices
    ));
  };

  # https://wiki.nixos.org/wiki/ACME
  security.acme = {
    acceptTerms = true;
    defaults.email = vars.userEmail;
    certs.${domainName} = {
      domain = domainName;
      group = config.services.nginx.group;
      extraDomainNames = map (service: service.prefix + "." + domainName) proxyServices;
    };
  };
}
