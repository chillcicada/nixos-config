{ inputs, pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
  };

  home.file.".config/nvim".source = inputs.nvim-config;

  # required by neovim
  home.packages = with pkgs; [
    gnumake # required by mason
    tree-sitter
    lua51Packages.lua
    luajitPackages.luarocks
  ];
}
