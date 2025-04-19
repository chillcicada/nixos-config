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

  programs.nix-ld.enable = true;

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
