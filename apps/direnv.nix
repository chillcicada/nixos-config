{ pkgs
, config
, ...
}:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      warn_timeout = 0;
    };
  };
}
