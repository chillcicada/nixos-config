{ pkgs
, config
, vars
, ...
}:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [

      ];
    };
  };
}
