current_hostname := `hostname`

# rebuild the system configuration
re TARGET=current_hostname:
  git add --all
  sudo nixos-rebuild switch --flake ."#{{TARGET}}" |& nom

# rebuild the system configuration but not switch
boot TARGET=current_hostname:
  git add --all
  sudo nixos-rebuild boot --flake ."#{{TARGET}}" |& nom

# rebuild the system configuration as root
re-as-root TARGET=current_hostname:
  nixos-rebuild switch --flake ."#{{TARGET}}" |& nom

# rebuild the system configuration but not switch as root
boot-as-root TARGET=current_hostname:
  nixos-rebuild boot --flake ."#{{TARGET}}" |& nom

# rebuild the system configuration with verbose output and print build logs
diagnosis TARGET=current_hostname:
  sudo nixos-rebuild switch --show-trace --verbose --print-build-logs --flake .#{{TARGET}} |& nom

# test the system configuration
test:
  nix flake check .

# list the system nix profiles
list:
  nix profile history --profile /nix/var/nix/profiles/system

# update the flake
up TARGET='':
  nix flake update {{TARGET}}

# build system and push to remote host
push TARGET:
  git add --all
  nixos-rebuild --target-host {{TARGET}} --use-remote-sudo switch --flake .#{{TARGET}} |& nom

# tree view of the system configuration dependencies
tree:
  nix-store --gc --print-roots | rg -v '/proc/' | rg -Po '(?<= -> ).*' | xargs -o nix-tree
