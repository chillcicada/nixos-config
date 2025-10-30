{ config, ... }:

{
  sops.secrets.webdav_auth = {
    owner = "webdav";
    group = "webdav";
  };

  users.users."webdav" = {
    # manually create the folder beforehand
    home = "/var/www/webdav";
    extraGroups = [ "webdav" ];
  };

  services.webdav-server-rs = {
    enable = true;
    debug = false;
    user = "webdav";

    # More config can be found at https://github.com/miquels/webdav-server-rs/blob/master/webdav-server.toml
    settings = {
      server.listen = [ "127.0.0.1:8081" ];

      accounts.auth-type = "htpasswd.default";

      # `nix shell nixpkgs#apacheHttpd`, then `htpasswd -B -c ./htpasswd <USERNAME>`
      htpasswd.default.htpasswd = config.sops.secrets.webdav_auth.path;

      location = [
        {
          # This is the default location, but we can override it
          route = [ "/(:path)" ];
          handler = "filesystem";
          methods = [ "webdav-ro" ];
          auth = "false";
          autoindex = true;

          # manually create the directory beforehand
          directory = "/var/www/webdav";
        }
        {
          route = [ "/public/*path" ];
          handler = "filesystem";
          methods = [ "webdav-ro" ];
          auth = "false";
          autoindex = true;

          # manually create the directory beforehand
          directory = "/var/www/webdav/public";
        }
        {
          route = [ "/private/*path" ];
          handler = "filesystem";
          methods = [ "webdav-rw" ];
          auth = "true";
          autoindex = true;

          # manually create the directory beforehand
          directory = "/var/www/webdav/private";
        }
      ];
    };
  };
}
