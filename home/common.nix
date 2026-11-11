{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

{
  # Enable Btop
  packages = [ pkgs.btop ];

  xdg.config.files."btop/btop.conf".text = ''
    theme_background = False
    log_level = "ERROR"
  '';

  # Enable Starship
  rum.programs.starship = {
    enable = true;
    integrations.zsh.enable = true;

    # https://starship.rs/config/
    settings = {
      username.disabled = true;
      nix_shell.disabled = true;

      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[×](bold red)";
      };
    };
  };

  # Some oh-my-zsh plugins expect the cache directory to exist.
  xdg.cache.files."oh-my-zsh/.keep".text = "";

  # Keep the zsh history directory around.
  xdg.data.files."zsh/.keep".text = "";

  # Enable Zsh & oh-my-zsh
  rum.programs.zsh = {
    enable = true;

    # Ordering mirrors the one Home Manager used for zsh.
    initConfig = lib.mkMerge [
      # Completion functions from packages must be on fpath before
      # compinit runs; oh-my-zsh calls compinit when it is sourced below.
      # NixOS links system packages' share/zsh into the system profile
      # (see modules/default.nix), while hjem packages are installed into
      # the per-user profile.
      (lib.mkOrder 690 ''
        fpath+=(
          ${pkgs.zsh-completions}/share/zsh/site-functions
          /run/current-system/sw/share/zsh/site-functions
          /etc/profiles/per-user/${vars.userName}/share/zsh/site-functions
        )
      '')

      (lib.mkOrder 700 ''
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      '')

      (lib.mkOrder 800 ''
        export ZSH="${pkgs.oh-my-zsh}/share/oh-my-zsh"
        ZSH_CACHE_DIR="${config.xdg.cache.directory}/oh-my-zsh"
        ZSH_THEME=""
        plugins=(git)

        source "$ZSH/oh-my-zsh.sh"
      '')

      (lib.mkOrder 1000 ''
        HISTFILE="${config.xdg.data.directory}/zsh/history"
        HISTSIZE=10000
        SAVEHIST=10000
        setopt HIST_IGNORE_ALL_DUPS
      '')

      (lib.mkOrder 1200 ''
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      '')
    ];
  };
}
