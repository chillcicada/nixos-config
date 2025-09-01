{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.neovim;
in

{
  options.neovim = {
    enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf cfg.enable {
    stylix.targets.neovim.enable = false;

    programs.neovim = {
      enable = true;

      viAlias = true;
    };

    home.file.".config/nvim".source = inputs.nvim-config;
  };
}
