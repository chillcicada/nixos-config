{ vars, pkgs, ... }:

{
  rum.programs.git = {
    enable = true;

    package = pkgs.gitMinimal;

    settings = {
      user = {
        name = vars.userFullname;
        email = vars.userEmail;
        timezone = "Asia/Shanghai";
        signingKey = vars.userSigningKey;
      };
      core.editor = "nvim";
      commit.gpgsign = true;
      credential.helper = "store";
      credential.credentialStore = "cache";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
