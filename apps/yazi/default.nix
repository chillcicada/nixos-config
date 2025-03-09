# more infomation can be found at https://yazi-rs.github.io/

{ pkgs
, config
, vars
, lib
, ...
}:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = lib.importTOML ./yazi.toml;
  };
}
