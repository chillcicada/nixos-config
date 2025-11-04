{ vars, ... }:

{
  # https://wiki.nixos.org/wiki/Nginx
  services.nginx = {
    enable = true;

    recommendedTlsSettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;

    virtualHosts =
      let
        proxy =
          host:
          {
            port,
            extra ? "",
          }:
          {
            useACMEHost = host;
            forceSSL = true;
            locations."/" = {
              proxyPass = "http://127.0.0.1:" + toString port;
              extraConfig = extra;
            };
          };
      in
      {
        "chillcicada.com" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            return = "200 '<html><body>Hello world!</body></html>'";
            extraConfig = ''
              default_type text/html;
            '';
          };
        };

        "uptime.chillcicada.com" = proxy "chillcicada.com" {
          port = 8080;
        };

        "webdav.chillcicada.com" = proxy "chillcicada.com" {
          port = 8081;
          extra = "client_max_body_size 1024M;";
        };

        "pastebin.chillcicada.com" = proxy "chillcicada.com" {
          port = 8082;
          extra = "client_max_body_size 1024M;";
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
