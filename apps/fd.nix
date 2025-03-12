{ pkgs, ... }:

{
  programs.fd = {
    enable = true;

    ignores = [
      ".ruff_cache/"
      ".git/"
      ".venv/"
      ".vscode/"
      "target/"
      "node_modules/"
      "dist/"
      "build/"
    ];
  };
}
