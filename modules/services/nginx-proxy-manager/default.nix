{ ... }:

{
  virtualisation.arion.projects.nginx-proxy-manager = {
    serviceName = "nginx-proxy-manager";
    settings = {
      services = {
        app.service = {
          image = "jc21/nginx-proxy-manager:latest";
          container_name = "nginx-proxy-manager";
          restart = "always";
          environment = {
            "DISABLE_IPV6" = "true";
            "X_FRAME_OPTIONS" = "sameorigin";
            "ENABLE_DNSMASQ" = "true";
          };
          volumes = [
            "/Storage/Services/Nginx-Proxy-Manager/data:/data"
            "/Storage/Services/Nginx-Proxy-Manager/letsencrypt:/etc/letsencrypt"
          ];
          ports = [
            "80:80"
            "443:443"
            "81:81"
          ];
          networks = [
            "public"
          ];
        };
      };
      networks = {
        public = {
          driver = "bridge";
        };
      };
    };
  };
}
