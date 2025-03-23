{
  pkgs,
  config,
  vars,
  ...
}:

{
  # required by typora
  programs.pandoc = {
    enable = true;
  };
}
