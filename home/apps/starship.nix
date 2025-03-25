{
  pkgs,
  config,
  vars,
  ...
}:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    # https://starship.rs/config/
    settings = {
      nix_shell.disabled = true;

      character = {
        success_symbol = "[λ](bold)";
        error_symbol = "[×](bold)";
      };
    };
  };
}
