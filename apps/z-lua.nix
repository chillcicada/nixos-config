{ pkgs
, config
, ...
}:

{
  programs.z-lua = {
    enable = true;
  };
}
