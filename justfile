current_hostname := `hostname`

re TARGET=current_hostname:
  git add .
  sudo nixos-rebuild switch --flake .#{{TARGET}}

re-as-root TARGET=current_hostname:
  nixos-rebuild switch --flake .#{{TARGET}} --rollback --show-trace --verbose

debug TARGET=current_hostname:
  sudo nixos-rebuild switch --flake .#{{TARGET}} --show-trace --verbose

diagnosis TARGET=current_hostname:
  sudo nixos-rebuild switch --flake .#{{TARGET}} --show-trace --verbose --print-build-logs

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
