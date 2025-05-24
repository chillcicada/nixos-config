{ ... }:

{
  programs.uv = {
    enable = true;

    # refer to https://docs.astral.sh/uv/configuration/
    settings = {
      python-preference = "system";
    };
  };
}
