{ config, ... }:

let
  webdavUser = "webdav";
  webdavGroup = "webdav";
  webdavRoot = "/var/www/webdav";
in
{
  sops.secrets.webdav_auth = {
    owner = webdavUser;
    group = webdavGroup;
  };

  users.users.${webdavUser} = {
    home = webdavRoot;
    extraGroups = [ webdavGroup ];
  };

  services.webdav-server-rs = {
    enable = true;

    user = webdavUser;

    settings = {
      server.listen = [ "127.0.0.1:8080" ];

      accounts.auth-type = "htpasswd.default";

      # The password was generated using:
      # `nix shell nixpkgs#apacheHttpd`, then `htpasswd -B -c ./htpasswd USERNAME`
      htpasswd.default.htpasswd = config.sops.secrets.webdav_auth.path;

      location = [
        {
          route = [ "/" ];
          handler = "filesystem";
          methods = [ "webdav-rw" ];
          auth = "true";
          autoindex = true;

          directory = "~";
        }
      ];
    };
  };
}
