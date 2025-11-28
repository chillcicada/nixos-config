{
  pkgs,
  inputs,
  vars,
  ...
}:

{
  imports = map (name: ./${name}) (
    builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ])
  );

  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    backupFileExtension = vars.hmBackupFileExtension;
    useUserPackages = true;
  };

  users.users.${vars.userName} = {
    isNormalUser = true;
    description = vars.userFullname;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # shell defined in home-manager
  };

  environment.shells = [ pkgs.zsh ];

  # Enable zsh to get completion for system packages
  environment.pathsToLink = [ "/share/zsh" ];

  environment.defaultPackages = [ ];

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

  # manually add the sops file
  sops.age.keyFile = "/home/${vars.userName}/.config/sops/age/keys.txt";

  # nixpkgs config
  nixpkgs.config.allowUnfree = true;

  # nix config
  nix.settings = {
    trusted-users = [ vars.userName ];
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Disable the NixOS channel
  nix.channel.enable = false;

  # Disable the NixOS manual
  documentation.enable = false;

  # openssh configuration
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
}
