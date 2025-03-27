{ pkgs, vars, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.git;
    userName = vars.userFullname;
    userEmail = vars.userEmail;
    extraConfig = {
      user.signingKey = vars.userSigningKey;
      user.timezone = "Asia/Shanghai";
      core.editor = "nvim";
      commit.gpgsign = true;
      credential.helper = "store";
      credential.credentialStore = "cache";
      init.defaultBranch = "main";
    };
    lfs.enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
  };
}
