{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    coreutils.enable = lib.mkEnableOption "coreutils";
  };

  config = lib.mkIf config.coreutils.enable {
    home.packages = with pkgs; [
      jq # json processor
      dust # disk usage
      tree # tree view
      sops # secrets management
      wget # download files
      unzip # unzip files, required by nvim
      killall # kill all processes by name
      nix-tree # nix tree view
      degit-rs # degit
      difftastic # diff tool
    ];
  };
}
