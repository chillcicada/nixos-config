{
  pkgs,
  inputs,
  vars,
  ...
}:

{
  imports = [
    ./docker.nix
    ./hardware.nix
    ./networking.nix

    ../../modules/core/nix.nix
    ../../modules/core/locale.nix
    ../../modules/core/system.nix
    ../../modules/core/nixpkgs.nix
    ../../modules/services/webdav
  ];

  boot.tmp.cleanOnBoot = true;

  zramSwap.enable = true;

  users = {
    users.${vars.userName} = {
      isNormalUser = true;
      description = vars.userFullname;
      extraGroups = [
        "networkmanager"
        "docker"
        "wheel"
      ];
      shell = pkgs.zsh;
    };
  };

  programs.zsh.enable = true;

  environment.shells = with pkgs; [ zsh ];

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

  environment.systemPackages = with pkgs; [
    merecat
  ];

  home-manager = {
    users.${vars.userName} = {
      imports = [ inputs.self.homeModules.salt ];
    };
  };

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      maple-mono.truetype
      maple-mono.NF-unhinted
      maple-mono.NF-CN-unhinted

      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [
          "Noto Serif CJK SC"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
        ];
        monospace = [
          "Maple Mono NF CN"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
