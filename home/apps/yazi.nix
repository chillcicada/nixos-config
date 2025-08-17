{ ... }:

{
  # refer to https://yazi-rs.github.io/ for more information
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

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
    };
  };
}
