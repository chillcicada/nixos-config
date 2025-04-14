{ inputs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
  };

  home.file.".config/nvim".source = inputs.nvim-config;
}
