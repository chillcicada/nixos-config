{ vars, ... }:

{
  imports = [
    ./nvidia.nix
    ./hardware.nix
    ./networking.nix
  ];

  users.users.${vars.userName}.extraGroups = [
    "networkmanager"
    "wheel"
  ];

  # Bootloader.
  boot.initrd.systemd.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-64f9a2a3-e6c3-418c-902d-dde61e57bdb3".device =
    "/dev/disk/by-uuid/64f9a2a3-e6c3-418c-902d-dde61e57bdb3";

  # Disable automatic generation of hardware-configuration.nix
  system.tools.nixos-generate-config.enable = false;

  # Enable userborn for user management.
  services.userborn.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true; # Required for pipewire.

  # Disable suspend on close lid
  services.logind.settings.Login.HandleLidSwitch = "ignore";

  # Enable nix-ld
  programs.nix-ld.enable = true;

  # Time Zone
  time.timeZone = "Asia/Shanghai";

  # Self defined options
  desktop.enable = true;
  essential.enable = true;

  # Fix XDG terminal exec
  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "com.mitchellh.ghostty.desktop" ];
  };

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty";
  };

  # Reset the default enabled programs
  programs.nano.enable = false;
}
