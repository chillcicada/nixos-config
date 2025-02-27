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

# update the all flake sources
up:
  sudo nix flake update

# update the nixpkgs flake source only
up-nixpkgs:
  sudo nix flake update nixpkgs

# update the nur flake source only
up-nur:
  sudo nix flake update nur

# set proxy for nix deamon
proxy:
  sudo ./scripts/proxy.sh

# switch on proxy
onproxy:
  ./scripts/onproxy.sh

# switch off proxy
offproxy:
  ./scripts/offproxy.sh

# format nix files
fmt:
  nixpkgs-fmt .
