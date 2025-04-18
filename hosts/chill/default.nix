{
  pkgs,
  inputs,
  vars,
  ...
}:

{
  imports = [
    ./hardware.nix
    ./networking.nix

    ../../modules/core
    ../../modules/gnome
    ../../modules/steam
    ../../modules/desktop
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

  security.sudo.extraRules = [
    {
      users = [ vars.userName ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  environment.systemPackages = with pkgs; [
    git
    just
    nix-output-monitor # nom
  ];

  home-manager = {
    users.${vars.userName} = {
      imports = [ inputs.self.homeModules.chill ];
    };
  };

  console = {
    earlySetup = true;
    font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  nixpkgs = {
    config = {
      permittedInsecurePackages = [ "electron-11.5.0" ];
    };
  };

  services.openssh = {
    ports = [
      vars.sshPort
      22
    ];
  };

  programs.nix-ld = {
    libraries = with pkgs; [
      icu # required by `marksman` for nvim
    ];
  };
}
