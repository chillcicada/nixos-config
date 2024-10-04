{ pkgs
, config
, vars
, ...
}:

{
  programs.z-lua = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "enhanced"
      "once"
      "fzf"
    ];
  };
}
