{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.develop;

  toml = pkgs.formats.toml { };
in

{
  options.develop = {
    cpp.enable = lib.mkEnableOption "cpp";
    nix.enable = lib.mkEnableOption "nix";
    misc.enable = lib.mkEnableOption "misc";
    rust.enable = lib.mkEnableOption "rust";
    python.enable = lib.mkEnableOption "python";
    frontend.enable = lib.mkEnableOption "frontend";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.cpp.enable {
      packages = with pkgs; [
        gcc
        xmake
      ];

      environment.sessionVariables = {
        XMAKE_GLOBALDIR = config.xdg.config.directory; # ~/.config
      };
    })

    (lib.mkIf cfg.nix.enable {
      packages = with pkgs; [
        nixd # linter
        nixfmt # formatter
      ];
    })

    (lib.mkIf cfg.python.enable {
      packages = with pkgs; [
        (python3.withPackages (ps: with ps; [ requests ]))
        ruff
        ty
        uv
      ];

      # refer to https://docs.astral.sh/ruff/configuration/
      xdg.config.files."ruff/ruff.toml".source = toml.generate "ruff.toml" {
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

      environment.sessionVariables = {
        SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      };
    })

    (lib.mkIf cfg.frontend.enable {
      packages = with pkgs; [
        pnpm
        nodejs
      ];
    })

    (lib.mkIf cfg.misc.enable {
      packages = with pkgs; [ just-lsp ];
    })

    (lib.mkIf cfg.rust.enable {
      packages = with pkgs; [
        rustup
      ];

      environment.sessionVariables = {
        CARGO_HOME = "$HOME/.local/share/cargo";
        RUSTUP_HOME = "$HOME/.local/share/rustup";
      };
    })
  ];
}
