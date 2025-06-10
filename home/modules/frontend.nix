{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    frontend.enable = lib.mkEnableOption "frontend";
  };

  config = lib.mkIf config.frontend.enable {
    home.packages = with pkgs; [
      pnpm
      eslint
      nodejs
    ];

    programs.bun = {
      enable = true;

      enableGitIntegration = true;

      # refer to https://bun.sh/docs/runtime/bunfig
      settings = {
        smol = true;
      };
    };
  };
}
