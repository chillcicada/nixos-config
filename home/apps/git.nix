{ vars, ... }:

{
  programs.git = {
    enable = true;
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
      pull.rebase = true;
    };
    lfs.enable = true;
  };

  # Eza with git
  programs.eza.git = true;
}
