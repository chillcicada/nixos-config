{ pkgs, ... }:

{
  # refer to https://yazi-rs.github.io/ for more information
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    initLua = ./init.lua;

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

    plugins = {
      inherit (pkgs.yaziPlugins) git starship;
    };
  };
}
