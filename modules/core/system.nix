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
  };

  users = {
    users.${vars.userName} = {
      isNormalUser = true;
      description = vars.userFullname;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.zsh;
    };
  };

  programs.zsh.enable = true;

  environment.shells = with pkgs; [ zsh ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu # required by `marksman` for nvim
    ];
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

  environment.systemPackages = with pkgs; [
    git
    just
    nix-output-monitor # nom
  ];
}
