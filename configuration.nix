{ pkgs
, inputs
, config
, vars
, ...
}:

{
  imports =
    [
      ./core
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-64f9a2a3-e6c3-418c-902d-dde61e57bdb3".device = "/dev/disk/by-uuid/64f9a2a3-e6c3-418c-902d-dde61e57bdb3";
  networking.hostName = vars.hostName;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.excludePackages = [ pkgs.xterm ];

  services.gnome.core-utilities.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-maps
    epiphany # web browser
    gnome-user-docs
    gnome-text-editor
    gnome-music
    gnome-contacts
    gnome-calculator
    simple-scan
    yelp # help viewer
    evince # document viewer
  ];

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  hardware.graphics.enable32Bit = true;
  services.pulseaudio.support32Bit = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."cc" = {
    isNormalUser = true;
    description = "ChillCicada";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Enable zsh
  programs.zsh.enable = true;

  environment.shells = with pkgs; [ zsh ];

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "cc";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    inputs.zen-browser.packages."${pkgs.system}".default
  ] ++ (with pkgs; [
    git
    wget
    curl
    just
    neovim
    cairo
    lua
    lua51Packages.lua
    luajitPackages.luarocks
    tree-sitter
    openssh
    fontconfig
    direnv
    cachix
    mangohud
    sops
    nix-init
    adwsteamgtk # for steam
    gnomeExtensions.appindicator
    adwaita-icon-theme
    gnome-tweaks
  ]);

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
  programs.dconf.enable = true;

  # Set default editor
  environment.variables = {
    EDITOR = "nvim";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint Electron apps to use Wayland
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # nvim config
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.nix-ld.enable = true;

  programs.clash-verge.enable = true;

  services.openssh.enable = true;

  networking.firewall = {
    enable = true;
    # Allow HTTP and SSH traffic
    allowedTCPPorts = [ 22 80 443 ];
    allowedUDPPorts = [ ];
  };

  system.stateVersion = "25.05";

  security.sudo.extraRules = [
    {
      users = [ "cc" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}

