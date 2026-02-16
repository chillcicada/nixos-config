{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.develop;
in

{
  options.develop = {
    cpp.enable = lib.mkEnableOption "cpp";
    nix.enable = lib.mkEnableOption "nix";
    python.enable = lib.mkEnableOption "python";
    frontend.enable = lib.mkEnableOption "frontend";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.cpp.enable {
      home.packages = with pkgs; [
        gcc
        xmake
      ];

      home.sessionVariables = {
        XMAKE_GLOBALDIR = config.xdg.configHome; # ~/.config
      };
    })

    (lib.mkIf cfg.nix.enable {
      home.packages = with pkgs; [
        nixd # linter
        nixfmt # formatter
        nix-output-monitor # nom
      ];
    })

    (lib.mkIf cfg.python.enable {
      home.packages = with pkgs; [ (python3.withPackages (ps: with ps; [ requests ])) ];

      programs.ruff = {
        enable = true;

        # refer to https://docs.astral.sh/ruff/configuration/
        settings = {
          exclude = [ ".venv" ];
          line-length = 120;
          indent-width = 4;
          target-version = "py313";

          lint = {
            select = [
              "E4"
              "E7"
              "E9"
              "F"
            ];
            ignore = [ ];
            fixable = [ "ALL" ];
            unfixable = [ ];
            dummy-variable-rgx = "^(_+|(_+[a-zA-Z0-9_]*[a-zA-Z0-9]+?))$";
          };

          format = {
            quote-style = "single";
            indent-style = "space";
            skip-magic-trailing-comma = false;
            line-ending = "lf";
            docstring-code-format = true;
            docstring-code-line-length = "dynamic";
          };
        };
      };

      programs.ty = {
        enable = true;
      };

      programs.uv = {
        enable = true;
      };

      home.sessionVariables = {
        SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      };
    })

    (lib.mkIf cfg.frontend.enable {
      home.packages = with pkgs; [
        pnpm
        nodejs
      ];
    })
  ];
}
