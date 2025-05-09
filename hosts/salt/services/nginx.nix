{ vars, ... }:

{
  # https://wiki.nixos.org/wiki/Nginx
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."img.chillcicada.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://0.0.0.0:2283";
      };
    };

    virtualHosts."webdav.chillcicada.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = vars.userEmail;
  };
}
