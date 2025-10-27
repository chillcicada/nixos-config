{ vars, ... }:

{
  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = {
      user.name = vars.userFullname;
      user.email = vars.userEmail;
      user.timezone = "Asia/Shanghai";
      user.signingKey = vars.userSigningKey;
      core.editor = "nvim";
      commit.gpgsign = true;
      credential.helper = "store";
      credential.credentialStore = "cache";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
