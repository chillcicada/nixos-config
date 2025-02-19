current_hostname := `hostname`

# rebuild the system configuration
re TARGET=current_hostname:
  git add --all
  sudo nixos-rebuild switch --flake .#{{TARGET}}

# rebuild the system configuration as root
re-as-root TARGET=current_hostname:
  nixos-rebuild switch --flake .#{{TARGET}}

# rebuild the system configuration with verbose output
debug TARGET=current_hostname:
  sudo nixos-rebuild switch --flake .#{{TARGET}} --show-trace --verbose

# rebuild the system configuration with verbose output and print build logs
diagnosis TARGET=current_hostname:
  sudo nixos-rebuild switch --flake .#{{TARGET}} --show-trace --verbose --print-build-logs

# test the system configuration
test:
  nix flake check .

# run nix garbage collection to free up disk space
gc:
  nix store gc

# clean all the system nix profiles
cleanall:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system

# list the system nix profiles
list:
  nix profile history --profile /nix/var/nix/profiles/system

# update the system flake lock file
up:
  sudo nix flake update

proxy:
  sudo sh ./scripts/proxy.sh

onproxy:
  sh ./scripts/onproxy.sh

offproxy:
  sh ./scripts/offproxy.sh

# format nix files
fmt:
  nixpkgs-fmt .
