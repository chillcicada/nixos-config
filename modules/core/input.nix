{ pkgs, ... }:

{
  /**
    currently gnome doesn't support text-input-v1 and doesn't plan to support it
    reference to: https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3751
    so some electron apps like discord, vscode and qq don't work well with fcitx5 and wayland flags
    this problem has been marked in https://github.com/chillcicada/nixos-config/issues/17

    other reference:
    - the input implementation in wayland:
      https://sh.alynx.one/posts/GNOME-IBus-Wayland-IME/
    - the present situation of the text input method implementation in wayland:
      https://zhuanlan.zhihu.com/p/22611314767
  */

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;

      addons = with pkgs; [
        fcitx5-gtk # gtk support

        fcitx5-mozc # japanese
        fcitx5-chinese-addons # chinese

        # pinyin lib supplement
        fcitx5-pinyin-zhwiki
        fcitx5-pinyin-moegirl
      ];

      ignoreUserConfig = false;

      settings = {
        inputMethod = {
          "Group/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Group/0/Items/0".Name = "keyboard-us";
          "Group/0/Items/1".Name = "shuangpin";
          "Group/0/Items/2".Name = "mozc";
          GroupOrder."0" = "Default";
        };
      };
    };
  };
}
