# more infomation can be found at https://yazi-rs.github.io/

{ pkgs
, config
, lib
, ...
}:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = lib.importTOML ./yazi.toml;
    theme = lib.importTOML ./theme.toml;
    keymap = lib.importTOML ./keymap.toml;
  };
}
