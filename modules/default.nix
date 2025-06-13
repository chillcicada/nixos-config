{
  pkgs,
  inputs,
  vars,
  ...
}:

{
  imports = map (name: ./${name}) (
    builtins.attrNames (
      removeAttrs (builtins.readDir ./.) [ "default.nix" ]
    )
  );

  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    backupFileExtension = "homeManagerBackup";
    useGlobalPkgs = true;
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

  programs.zsh.enable = true;

  environment.shells = with pkgs; [ zsh ];

  environment.defaultPackages = [ ];

  # manually add the sops file
  sops.age.keyFile = "/home/${vars.userName}/.config/sops/age/keys.txt";

  # nixpkgs config
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  # nix config
  nix = {
    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ vars.userName ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      UseDns = true;
      AllowUsers = [ vars.userName ];
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = true;
    };
  };
}
