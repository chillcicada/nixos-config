{ ... }:

{
  programs.fd = {
    enable = true;

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
