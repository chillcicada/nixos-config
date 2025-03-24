{ pkgs, ... }:

{
  services.gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;
}
