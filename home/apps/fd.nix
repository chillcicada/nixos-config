{ pkgs, ... }:

{
  packages = [ pkgs.fd ];

  xdg.config.files."fd/ignore".text = ''
    .cache/
    .ruff_cache/
    .git/
    .venv/
    .vscode/
    target/
    node_modules/
    dist/
    build/
  '';
}
