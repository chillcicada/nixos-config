re:
  sudo nixos-rebuild switch --flake .#chill

debug:
  sudo nixos-rebuild switch --flake .#chill --show-trace --verbose

test:
  nix flake check .

gc:
  nix store gc

cleanall:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system

list:
  nix profile history --profile /nix/var/nix/profiles/system

up:
  sudo nix flake update --commit-lock-file
