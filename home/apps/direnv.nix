{ ... }:

{
  rum.programs.direnv = {
    enable = true;
    integrations = {
      nix-direnv.enable = true;
      zsh.enable = true;
    };

    settings = {
      warn_timeout = 0; # disable warning timeout
      global.hide_env_diff = true;
    };
  };
}
