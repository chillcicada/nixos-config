{ pkgs, ... }:

{
  programs.bun = {
    enable = true;
    package = pkgs.bun;

    enableGitIntegration = true;

    # refer to https://bun.sh/docs/runtime/bunfig
    settings = {
      smol = true;
    };
  };
}
