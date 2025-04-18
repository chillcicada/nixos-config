{ pkgs, ... }: {
  imports = [
    ./hardware.nix
    
    
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "VM-24-16-debian";
  networking.domain = "localdomain";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOePB6daXwlpCLOC+pgnbsQ+V8HdsLLbjJb4poYKXfIyA3qBPYwY6fzpug4mjGviMNoJI9Tx9n5XAkhg6fMf4fomUNO3DiG9RXP7S0Z12lR9J/c2pZv7ErAoY+ft2Hi6wuLYFiZ/iwnbubojjFj4Sl7rC85fSbXxeCZDe0u12AxOjeH55XNsAcjWa5OuA50jcD/rZy3nDf+OEvEqM3Lx6fMgneiVDLChqDBopTNvD0tqi7kOaKD/XXxMxCw4jROY0DWSPJBRuJChb+lXdy7Kc5afiGB01jTjbV/YSbcMqeHhgLvHBzu7IoO5q8mLIj9f8Lprew/7wPmU3ipzCRIipypx7IRmPk9dg5Zoh+YQOVHdtMsjwZFnWWEhiJv3SBlUMhPcTk695O9ZUs93LOkYxpS4nNIy3dd5OJACpMcXrh3wno39uMz3AROn68rHr1XAVnJwuZdPojRKAtFG8QNp51GNWJ6Dh7M+ehBhG5mfoYFKNxRcg2nvDTASAOn161l/E= skey-7nutbt5n'' ];
  system.stateVersion = "23.11";

  environment.systemPackages = [
    pkgs.git
  ];
}
