{
  pkgs,
  config,
  vars,
  ...
}:

{
  programs.bat = {
    enable = true;

    extraPackages = with pkgs.bat-extras; [ ];
  };
}
