{ pkgs
, config
, vars
, ...
}:

{
  programs.firefox = {
    enable = true;
  };
}
