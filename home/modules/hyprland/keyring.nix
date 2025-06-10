{ lib, config, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    services.gnome-keyring = {
      enable = true;
    };
  };
}
