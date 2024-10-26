{ pkgs
, config
, vars
, ...
}:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    catppuccin.enable = true;

    # https://starship.rs/config/
    settings = {
      nix_shell.disabled = true;
    };
  };
}
