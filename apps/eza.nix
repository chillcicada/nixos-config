{
  pkgs,
  config,
  vars,
  ...
}:

{
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };
}
