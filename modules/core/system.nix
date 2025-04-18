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

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu # required by `marksman` for nvim
    ];
  };

  services.openssh = {
    enable = true;
    ports = [ vars.sshPort ];
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
