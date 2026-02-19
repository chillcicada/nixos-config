{
  lib,
  pkgs,
  inputs,
  vars,
  ...
}:

{
  imports = map (name: ./${name}) (
    builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ])
  );

  # Config home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    backupFileExtension = vars.hmBackupFileExtension;
    useUserPackages = true;
  };

  # Define the main user
  users.users.${vars.userName} = {
    isNormalUser = true;
    description = vars.userFullname;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # shell defined in home-manager
    openssh.authorizedKeys.keys = vars.opensshKeys;
  };

  environment.shells = [ pkgs.zsh ];

  # Enable zsh to get completion for system packages
  environment.pathsToLink = [ "/share/zsh" ];

  # Disable default packages
  environment.defaultPackages = lib.mkDefault [ ];

  # No password sudo for the main user
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

  # Manually add the sops file
  sops.age.keyFile = "/home/${vars.userName}/.config/sops/age/keys.txt";

  # Nixpkgs config
  nixpkgs.config.allowUnfree = true;

  # Nix config
  nix.settings = {
    trusted-users = [ vars.userName ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Disable the NixOS channel
  nix.channel.enable = lib.mkDefault false;

  # Disable info pages and the NixOS manual
  documentation.info.enable = lib.mkDefault false;
  documentation.nixos.enable = lib.mkDefault false;

  # Openssh configuration
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      UseDns = true;
      AllowUsers = [ vars.userName ];
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };

  # Journal configuration
  services.journald = {
    extraConfig = ''
      MaxRetentionSec=7day
      MaxFileSec=1day
    '';
  };
}
