{ pkgs, ... }:

{
  imports = [ ./home ];

  home.packages = with pkgs; [
    # js/ts
    pnpm
    nodejs

    # python
    uv
    python312

    # rust
    rustup
  ];
}
