{
  pkgs,
  config,
  vars,
  ...
}:

{
  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
    };
  };
}
