current_hostname := `hostname`

# rebuild the system configuration
re TARGET=current_hostname:
  git add --all
  sudo nixos-rebuild switch --flake .#{{TARGET}} |& nom

# rebuild the system configuration bubt not switch
boot TARGET=current_hostname:
  git add --all
  sudo nixos-rebuild boot --flake .#{{TARGET}} |& nom

# rebuild the system configuration as root
re-as-root TARGET=current_hostname:
  nixos-rebuild switch --flake .#{{TARGET}} |& nom

# rebuild the system configuration with verbose output
debug TARGET=current_hostname:
  sudo nixos-rebuild switch --show-trace --verbose --flake .#{{TARGET}} |& nom

# rebuild the system configuration with verbose output and print build logs
diagnosis TARGET=current_hostname:
  sudo nixos-rebuild switch  --show-trace --verbose --print-build-logs --flake .#{{TARGET}} |& nom

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

# update the flake
up TARGET='':
  sudo nix flake update {{TARGET}}

# format nix files
fmt:
  treefmt

# find all the files that get backup by home-manager
fd:
  fd -H -e '.homeManagerBackup' -p ~
