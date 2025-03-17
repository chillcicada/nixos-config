{
  pkgs,
  inputs,
  vars,
  ...
}:

{
  users.users."${vars.userName}" = {
    isNormalUser = true;
    description = vars.userFullname;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  environment.shells = with pkgs; [ zsh ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.nix-ld.enable = true;

  programs.clash-verge.enable = true;

  services.openssh.enable = true;

  environment.systemPackages =
    [ inputs.zen-browser.packages."${pkgs.system}".default ]
    ++ (with pkgs; [
      git
      wget
      curl
      just
      direnv

      sops
      cachix
      fontconfig

      cairo
      openssl
      mangohud
    ]);

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
