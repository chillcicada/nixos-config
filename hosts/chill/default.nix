{
  pkgs,
  inputs,
  vars,
  ...
}:

{
  imports = [
    ./nvidia.nix
    ./hardware.nix
    ./networking.nix

    ../../modules/core
    ../../modules/games
    ../../modules/graphics
    ../../modules/desktop/gnome
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-64f9a2a3-e6c3-418c-902d-dde61e57bdb3".device =
    "/dev/disk/by-uuid/64f9a2a3-e6c3-418c-902d-dde61e57bdb3";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pulse and pipewire.
  services.pulseaudio = {
    enable = false;
    support32Bit = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true; # Required for pulse and pipewire.

  # Enable wayland support.
  environment.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    QT_IM_MODULE = "fcitx";
    QT_QPA_PLATFORM = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    git
    just
    nix-output-monitor # nom
  ];

  home-manager.users.${vars.userName}.imports = [ inputs.self.homeModules.chill ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-11.5.0"
    "clash-verge-rev-2.2.3"
    "clash-verge-rev-unwrapped-2.2.3"
    "clash-verge-rev-webui-2.2.3"
    "clash-verge-rev-service-2.2.3"
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu # required by `marksman` for nvim
    ];
  };
}
