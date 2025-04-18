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
    ../../modules/services/nginx-proxy-manager
  ];

  boot.tmp.cleanOnBoot = true;

  zramSwap.enable = true;

  users.extraGroups.docker.members = [ vars.userName ];

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
