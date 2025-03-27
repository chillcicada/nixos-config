{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    enableZshIntegration = true;

    # https://starship.rs/config/
    settings = {
      hostname.disabled = true;
      username.disabled = true;
      nix_shell.disabled = true;

      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[×](bold red)";
      };
    };
  };
}
