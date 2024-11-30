re:
  git add .
  sudo nixos-rebuild switch --flake .#chill

debug:
  sudo nixos-rebuild switch --flake .#chill --show-trace --verbose

fulldebug:
  sudo nixos-rebuild switch --flake .#chill --show-trace --verbose --print-build-logs

test:
  nix flake check .

gc:
  nix store gc

cleanall:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system

list:
  nix profile history --profile /nix/var/nix/profiles/system

up:
  sudo nix flake update

proxy:
  sudo sh ./scripts/proxy.sh

onproxy:
  sh ./scripts/onproxy.sh

offproxy:
  sh ./scripts/offproxy.sh

fmt:
  nixpkgs-fmt .
