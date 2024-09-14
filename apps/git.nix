{ pkgs
, config
, ...
}:

{
  programs.git = {
    enable = true;
    userName = "chillcicada";
    userEmail = "2210227279@qq.com";
    extraConfig = {
      user.signingKey = "34C212310A99754B";
      core.editor = "nvim";
      commit.gpgsign = true;
      credential.helper = "store";
      credential.credentialStore = "cache";
      init.defaultBranch = "main";
    };
    lfs.enable = true;
  };
}
