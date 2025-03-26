{
  pkgs,
  inputs,
  vars,
  ...
}:

{
  home-manager = {
    extraSpecialArgs = { inherit inputs vars; };
    backupFileExtension = "homeManagerBackup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${vars.userName} = {
      imports = [ inputs.self.homeModules.chill ];
    };
  };

  users.users."${vars.userName}" = {
    isNormalUser = true;
    description = vars.userFullname;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [ zsh ];

  programs.zsh.enable = true;

  programs.nix-ld.enable = true;

  programs.clash-verge = {
    enable = true;
    autoStart = true;
  };

  services.openssh = {
    enable = true;
    ports = [ 20202 ];
    openFirewall = true;
    settings = {
      UseDns = true;
      AllowUsers = [ vars.userName ];
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    just
    fontconfig # font
    nix-output-monitor # nom
  ];

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
}
