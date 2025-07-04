{ lib, ... }:

{
  services.openssh.ports = [
    22
    20202 # the lower ports is gotten blocked by the THU
  ];

  networking = {
    networkmanager = {
      enable = true;
    };

    useDHCP = lib.mkDefault true;

    extraHosts = ''
      140.82.112.26                 alive.github.com
      140.82.121.5                  api.github.com
      185.199.109.153               assets-cdn.github.com
      185.199.108.133               avatars.githubusercontent.com
      185.199.111.133               avatars0.githubusercontent.com
      185.199.109.133               avatars1.githubusercontent.com
      185.199.111.133               avatars2.githubusercontent.com
      185.199.109.133               avatars3.githubusercontent.com
      185.199.110.133               avatars4.githubusercontent.com
      185.199.111.133               avatars5.githubusercontent.com
      185.199.110.133               camo.githubusercontent.com
      140.82.112.22                 central.github.com
      185.199.111.133               cloud.githubusercontent.com
      140.82.121.10                 codeload.github.com
      140.82.113.22                 collector.github.com
      185.199.110.133               desktop.githubusercontent.com
      185.199.109.133               favicons.githubusercontent.com
      140.82.121.3                  gist.github.com
      52.217.167.161                github-cloud.s3.amazonaws.com
      16.182.38.193                 github-com.s3.amazonaws.com
      3.5.7.144                     github-production-release-asset-2e65be.s3.amazonaws.com
      16.182.40.97                  github-production-repository-file-5c1aeb.s3.amazonaws.com
      3.5.7.144                     github-production-user-asset-6210df.s3.amazonaws.com
      192.0.66.2                    github.blog
      140.82.121.4                  github.com
      140.82.114.17                 github.community
      185.199.108.154               github.githubassets.com
      151.101.1.194                 github.global.ssl.fastly.net
      185.199.110.153               github.io
      185.199.108.133               github.map.fastly.net
      185.199.109.153               githubstatus.com
      140.82.114.25                 live.github.com
      185.199.110.133               media.githubusercontent.com
      185.199.111.133               objects.githubusercontent.com
      13.107.42.16                  pipelines.actions.githubusercontent.com
      185.199.108.133               raw.githubusercontent.com
      185.199.110.133               user-images.githubusercontent.com
      13.107.246.60                 vscode.dev
      140.82.113.21                 education.github.com
      185.199.109.133               private-user-images.githubusercontent.com
    '';

    firewall = {
      enable = true;
      # Allow HTTP and SSH traffic
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedTCPPortRanges = [
        {
          from = 20000;
          to = 65535;
        }
      ];
      allowedUDPPorts = [ ];
      allowedUDPPortRanges = [
        {
          from = 20000;
          to = 65535;
        }
      ];
    };
  };
}
