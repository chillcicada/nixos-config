{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    typora
  ];

  home.file.".config/Typora/themes".source = inputs.typora-themes;
}
