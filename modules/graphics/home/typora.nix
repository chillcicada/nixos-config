{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    typora
  ];

  # required by typora
  programs.pandoc = {
    enable = true;
  };

  home.file.".config/Typora/themes".source = inputs.typora-themes;
}
