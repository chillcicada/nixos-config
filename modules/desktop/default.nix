{
  pkgs,
  vars,
  lib,
  config,
  inputs,
  ...
}:

let
  cfg = config.desktop;

  allowedTypes = lib.types.enum [
    "gnome"
    "hyprland"
  ];
in

{
  options.desktop = {
    enable = lib.mkEnableOption "desktop";

    wm = lib.mkOption {
      type = allowedTypes;
      default = "gnome";
      defaultText = lib.literalMD "The value of your windows manager, defaulting to null";
      example = "gnome";
      description = "The windows manager option.";
    };
  };

  imports = map (name: ./${name}) (
    builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ])
  );

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = with inputs; [ chillcicada.overlays.default ];

    services = {
      # Use gdm as the display manager.
      displayManager = {
        gdm.enable = true;

        # Enable automatic login for the user.
        autoLogin.enable = true;
        autoLogin.user = vars.userName;
      };

      # X11 configuration
      xserver = {
        enable = true;
        excludePackages = with pkgs; [ xterm ];

        xkb.layout = "us";
      };
    };

    # Enable wayland support.
    environment.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      NIXOS_OZONE_WL = "1";
      QT_IM_MODULE = "fcitx";
    };

    # Locale
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Input Method Fcitx5
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

      the solution is to use fcitx5 with xwayland frontend for specific apps
    */

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";

      fcitx5 = {
        waylandFrontend = true;

        addons = with pkgs; [
          fcitx5-gtk # gtk support

          fcitx5-mozc # japanese
          qt6Packages.fcitx5-chinese-addons # chinese

          # pinyin lib supplement
          fcitx5-pinyin-zhwiki
          fcitx5-pinyin-moegirl

          chillcicada.fcitx5-pinyin-custom-dictionary
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

    fonts = {
      enableDefaultPackages = true;
      fontconfig.enable = true;
    };

    # Console
    console = {
      earlySetup = true;
      font = "ter-i32b";
      packages = [ pkgs.terminus_font ];
      keyMap = "us";
    };
  };
}
