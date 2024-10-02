{ pkgs
, config
, vars
, ...
}:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
