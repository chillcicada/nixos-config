_:

{
  programs.bun = {
    enable = true;

    enableGitIntegration = true;

    # refer to https://bun.sh/docs/runtime/bunfig
    settings = {
      smol = true;
    };
  };
}
