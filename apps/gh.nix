{ pkgs
, config
, ...
}:

{
  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";
    };

    extensions = [ ];
  };
}
