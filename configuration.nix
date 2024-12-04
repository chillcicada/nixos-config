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

  networking.extraHosts = ''
    127.0.0.1      www.bilibili.com
  '';

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.excludePackages = [ pkgs.xterm ];

  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # programs.hyprland = {
  #   enable = true;
  #   withUWSM = true;
  #   xwayland.enable = true;
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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

  nix = {
    settings = {
      auto-optimise-store = true;
      # Enable experimental features
      experimental-features = [ "nix-command" "flakes" ];
    };

    # Storage optimization
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."cc" = {
    isNormalUser = true;
    description = "ChillCicada";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
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

  # Nixpkgs config
  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    just
    neovim
    lua
    lua51Packages.lua
    luajitPackages.luarocks
    tree-sitter
    openssh
    fontconfig
    direnv
    nerd-font-patcher
    cachix
    clash-verge-rev
    mangohud
    sops
    nix-init

    adwsteamgtk # for steam

    compose2nix
    docker-compose
  ];

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

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "24.11";

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

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  # docker config
  virtualisation.docker = {
    enable = true;
    daemon = {
      settings = {
        proxies = {
          http-proxy = "http://127.0.0.1:7897";
          https-proxy = "http://127.0.0.1:7897";
          no-proxy = "localhost";
        };
      };
    };
  };
}

