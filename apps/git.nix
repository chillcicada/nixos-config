{ pkgs, config, vars, ... }:

{
  programs.git = {
    enable = true;
    userName = vars.gitName;
    userEmail = vars.userEmail;
    extraConfig = {
      user.signingKey = "34C212310A99754B";
      user.timezone = "Asia/Shanghai";
      core.editor = "nvim";
      commit.gpgsign = true;
      credential.helper = "store";
      credential.credentialStore = "cache";
      init.defaultBranch = "main";
    };
    lfs.enable = true;
  };
}
