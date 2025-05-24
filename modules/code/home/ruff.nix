{ ... }:

{
  programs.ruff = {
    enable = true;

    # refer to https://docs.astral.sh/ruff/configuration/
    settings = {
      exculude = [ ".venv" ];
      line-length = 120;
      indent-width = 4;
      target-version = "py312";

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
}
