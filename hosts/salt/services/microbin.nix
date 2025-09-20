{ vars, ... }:

{
  services.microbin = {
    enable = true;

    # https://microbin.eu/docs/installation-and-configuration/configuration/
    settings = {
      MICROBIN_BIND = "127.0.0.1";
      MICROBIN_PORT = "8082";
      MICROBIN_WIDE = "true";
      MICROBIN_HIDE_LOGO = "true";
      MICROBIN_HIDE_FOOTER = "true";
      MICROBIN_ADMIN_USERNAME = vars.userFullname;
      MICROBIN_HIGHLIGHTSYNTAX = "true";
      MICROBIN_DISABLE_TELEMETRY = "true";
    };
  };
}
