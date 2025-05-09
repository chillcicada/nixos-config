{ config, ... }:

{
  sops.secrets.webdav_auth = {
    owner = "webdav";
    group = "webdav";
  };

  users.users."webdav" = {
    home = "/var/www/webdav";
    extraGroups = [ "webdav" ];
  };

  services.webdav-server-rs = {
    enable = true;

    debug = true;

    user = "webdav";

    settings = {
      server.listen = [ "127.0.0.1:8080" ];

      accounts.auth-type = "htpasswd.default";

      # `nix shell nixpkgs#apacheHttpd`, then `htpasswd -B -c ./htpasswd USERNAME`
      htpasswd.default.htpasswd = config.sops.secrets.webdav_auth.path;

      location = [
        {
          route = [ "/*path" ];
          handler = "filesystem";
          methods = [ "webdav-rw" ];
          auth = "true";
          autoindex = true;

          directory = "/var/www/webdav";
        }
      ];
    };
  };
}
