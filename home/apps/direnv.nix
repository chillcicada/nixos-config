{ ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    config = {
      warn_timeout = 0; # disable warning timeout
    };

    config.global = {
      hide_env_diff = true;
    };
  };
}
