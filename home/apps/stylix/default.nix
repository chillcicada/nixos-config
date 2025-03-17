{
  pkgs,
  config,
  vars,
  ...
}:

{
  stylix = {
    enable = true;
    # TODO: remove this by nix module
    image = ./bg.jpg;

    polarity = "dark";
    autoEnable = true;

    targets = {
      gtk.enable = true;

      kitty.enable = false;
      fzf.enable = false;
      yazi.enable = false;
      btop.enable = false;
      bat.enable = false;
      vscode.enable = false;
      neovim.enable = false;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
