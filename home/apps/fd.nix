{ pkgs, ... }:

{
  programs.fd = {
    enable = true;
    package = pkgs.fd;

    ignores = [
      ".cache/"
      ".ruff_cache/"
      ".git/"
      ".venv/"
      ".vscode/"
      "target/"
      "node_modules/"
      "dist/"
      "build/"
    ];

    extraOptions = [ ];
  };
}
