{
  pkgs,
  config,
  vars,
  ...
}:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
  };
}
