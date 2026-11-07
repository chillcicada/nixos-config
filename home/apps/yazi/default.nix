{ pkgs, ... }:

{
  # refer to https://yazi-rs.github.io/ for more information
  rum.programs.yazi = {
    enable = true;

    settings = {
      mgr = {
        show_hidden = true;
        show_symlink = true;
      };
      preview = {
        wrap = "yes";
        tab_size = 2;
      };
      opener = {
        edit = [
          {
            run = "nvim $@";
            block = true;
          }
        ];
      };
      plugin = {
        prepend_fetchers = [
          {
            url = "*";
            run = "git";
            group = "git";
          }
          {
            url = "*/";
            run = "git";
            group = "git";
          }
        ];
      };
    };
  };

  packages = [ pkgs.starship ];

  xdg.config.files = {
    "yazi/init.lua".source = ./init.lua;
    "yazi/plugins/git.yazi".source = pkgs.yaziPlugins.git;
    "yazi/plugins/starship.yazi".source = pkgs.yaziPlugins.starship;
  };

  rum.programs.zsh.initConfig = ''
    function y() {
      local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
      command yazi "$@" --cwd-file="$tmp"
      if cwd="$(<"$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
      fi
      rm -f -- "$tmp"
    }
  '';
}
