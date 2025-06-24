{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    fcitx5.enable = lib.mkEnableOption "fcitx5";
  };

  config = lib.mkIf config.fcitx5.enable {
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
          nur.repos.chillcicada.fcitx5-pinyin-custom-dictionary
        ];

        ignoreUserConfig = false;

        settings = {
          addons = {
            pinyin = {
              globalSection = {
                ShuangpinProfile = "Ziranma";
                ShowShuangpinMode = "True";
                PageSize = 9;
                SpellEnabled = "False";
                SymbolsEnabled = "False";
                ChaiziEnabled = "True";
                ExtBEnabled = "True";
                CloudPinyinEnabled = "False";
                CloudPinyinIndex = 2;
                CloudPinyinAnimation = "True";
                KeepCloudPinyinPlaceHolder = "False";
                PreeditMode = "\"Composing pinyin\"";
                PreeditCursorPositionAtBeginning = "True";
                PinyinInPreedit = "False";
                Prediction = "False";
                PredictionSize = 10;
                SwitchInputMethodBehavior = "\"Commit current preedit\"";
                SecondCandidate = "";
                ThirdCandidate = "";
                UseKeypadAsSelection = "False";
                BackSpaceToUnselect = "True";
                "Number of sentence" = 2;
                LongWordLengthLimit = 4;
                VAsQuickphrase = "False";
                FirstRun = "False";
                QuickPhraseKey = "";
              };
              sections = {
                Fuzzy = {
                  VE_UE = "True";
                  NG_GN = "False";
                  Inner = "False";
                  InnerShort = "False";
                  PartialFinal = "False";
                  PartialSp = "False";
                  V_U = "True";
                  AN_ANG = "False";
                  EN_ENG = "False";
                  IAN_IANG = "False";
                  IN_ING = "True";
                  U_OU = "False";
                  UAN_UANG = "False";
                  C_CH = "False";
                  F_H = "False";
                  L_N = "True";
                  S_SH = "False";
                  Z_ZH = "False";
                  Correction = "None";
                };
              };
            };
          };

          inputMethod = {
            "Group/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "keyboard-us";
            };

            "Group/0/Items/0" = {
              Name = "keyboard-us";
              Layout = "";
            };

            "Group/0/Items/1" = {
              Name = "shuangpin";
              Layout = "";
            };

            "Group/0/Items/2" = {
              Name = "mozc";
              Layout = "";
            };

            GroupOrder."0" = "Default";
          };

          globalOptions = {
            Hotkey = {
              EnumerateWithTriggerKeys = true;
              EnumerateSkipFirst = false;
            };
          };
        };
      };
    };

    environment.sessionVariables = {
      XMODIFIERS = "@im=fcitx";
      QT_IM_MODULE = "fcitx";
    };
  };
}
