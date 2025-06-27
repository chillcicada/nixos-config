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
    QT_QPA_PLATFORM = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  # Home Manager Entry
  home-manager.users.${vars.userName}.imports = [ inputs.self.homeModules.chill ];

  # Todo: remove this
  # Enable nix-ld
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu # required by `marksman` for nvim
    ];
  };

  # Time Zone.
  time.timeZone = "Asia/Shanghai";

  # self defined options
  desktop.enable = true;
  essential.enable = true;
  essential.proxy.enable = true;
  steam.enable = true;
}
