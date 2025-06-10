{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    tools.enable = lib.mkEnableOption "tools";
  };

  config = lib.mkIf config.tools.enable {
    home.packages = with pkgs; [
      tokei # count code lines
      treefmt # tree format
    ];
  };
}
