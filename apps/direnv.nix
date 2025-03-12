{ pkgs, config, vars, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = { warn_timeout = 0; };
    enableZshIntegration = true;
    enableBashIntegration = true;
    config.global = { hide_env_diff = true; };
  };
}
