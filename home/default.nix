{ vars, ... }:

{
  home = {
    username = vars.userName;
    homeDirectory = "/home/${vars.userName}";
  };

  # https://nix-community.github.io/home-manager/options.xhtml
  imports = map (name: ./${name}) (
    builtins.attrNames (
      removeAttrs (builtins.readDir ./.) [
        "default.nix"
        "minimal.nix"
      ]
    )
  );

  programs.home-manager.enable = true;
}
