{ inputs, pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
  };

  stylix.targets.neovim.enable = false;

  home.file.".config/nvim".source = inputs.nvim-config;

  # required by neovim
  home.packages = with pkgs; [
    gnumake # required by mason
    tree-sitter
    lua51Packages.lua
    luajitPackages.luarocks
  ];
}
