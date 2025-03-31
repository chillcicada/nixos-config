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

  programs.zsh.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu # required by `marksman` for nvim
    ];
  };

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

  environment.shells = with pkgs; [ zsh ];

  environment.systemPackages = with pkgs; [
    git
    just
    nix-output-monitor # nom
  ];
}
