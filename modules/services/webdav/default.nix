{ ... }:
let
  app = "webdav";
  appDir = "/var/www/${app}";
in
{
  services = {
    # reverse proxy
    caddy = {
      enable = true;
      user = app;
      virtualHosts = {
        "webdav.chillcicada.com" = {
          extraConfig = ''
            reverse_proxy localhost:8080 {
              header_up Host {host}
              header_up X-Real-IP {remote}
              header_up Connection {>Connection}
              header_up X-Forwarded-Port {port}
              header_up X-Forwarded-Ssl on
            }
          '';
        };
      };
    };
    webdav-server-rs = {
      enable = true;
      user = app;
      settings = {
        server.listen = [ "127.0.0.1:8080" ];
        accounts = {
          auth-type = "htpasswd.default";
          acct-type = "unix";
        };
        htpasswd.default = {
          htpasswd = "/etc/htpasswd";
        };

        location = [
          {
            route = [ "/zotero/*path" ];
            directory = "/var/www/webdav/zotero/";
            handler = "filesystem";
            methods = [ "webdav-rw" ];
            autoindex = true;
            auth = "true";
          }
        ];
      };
    };
  };

  # user for caddy and phpfpm
  users.users.${app} = {
    isSystemUser = true;
    createHome = true;
    home = appDir;
    group = app;
  };
  users.groups.${app} = { };
}
