{ pkgs
, config
, vars
, ...
}:

{
  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";
      editor  = "Code";
    };

    extensions = [ ];
  };
}
