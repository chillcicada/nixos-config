# vscode configuration
# hint: if you use wayland, you should set `NIXOS_OZONE_WL=1`
# example as `environment.sessionVariables.NIXOS_OZONE_WL = "1"` in your configuration.
# refer to `https://nixos.wiki/wiki/Visual_Studio_Code#Wayland`
{ pkgs
, config
, ...
}:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # theme
      fisheva.eva-theme

      # icon
      atommaterial.a-file-icon-vscode

      # markdown
      yzhang.markdown-all-in-one
      nuxt.mdc
      unifiedjs.vscode-mdx

      # svelte
      svelte.svelte-vscode

      # js / ts (node / bun)
      oven.bun-vscode                # bun
      antfu.goto-alias               # go to alias in `d.ts`
      bengreenier.vsocde-node-readme # npm readme preview
      yoavbls.pretty-ts-errors       # pretty ts errors
      wix.vscode-import-cost         # import cost
      vitest.explorer                # vitest
      dbaeumer.vscode-eslint         # eslint
      esbenp.prettier-vscode         # prettier
      rvest.vs-code-prettier-eslint  # eslint x prettier

      # css
      csstools.postcss
      pranaygp.vscode-css-peek

      # unocss
      antfu.unocss

      # vanjs
      taoxin.vanjs-importtag

      # git
      codezombiech.gitignore
      donjayamanne.githistory

      # python
      charliermarsh.ruff
      donjayamanne.python-extension-pack

      # nix
      bbenoist.nix

      # xml
      redhat.vscode-xml

      # yaml
      reahat.vscode-yaml

      # toml
      tamasfe.even-better-toml

      # typst
      myriad-dreamin.tinymist

      # lua
      kampfkarren.selene-vscode
      johnnymorganz.stylua

      # jupyter
      ms-toolsai.jupyter
      ms-toolsai.datawrangler

      # vue
      vue.volar

      aeschli.vscode-css-formatter
      chakrounanas.turbo-console-log
      christian-kohler.npm-intellisense
      christian-kohler.path-intellisense
      davidanson.vscode-markdownlint
      dsznajder.es7-react-js-snippets
      formulahendry.code-runner
      github.copilot
      github.copilot-chat
      github.remotehub
      github.vscode-github-actions
      github.vscode-pull-request-github
      guyutongxue.pause-console
      ibm.output-colorizer
      jakearl.search-editor-apply-changes
      jasonnutter.search-node-modules
      jeff-hykin.better-cpp-syntax
      johnsoncodehk.vscode-tsconfig-helper
      lokalise.i18n-ally
      mhutchie.git-graph
      mikestead.dotenv
      mrmlnc.vscode-autoprefixer
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode.cpptools
      ms-vscode.makefile-tools
      ms-vscode.vscode-typescript-next
      ms-vsliveshare.vsliveshare
      shd101wyy.markdown-preview-enhanced
      sporiley.css-auto-prefix
      zignd.html-css-class-completion

      # astro
      astro-build.astro-vscode

      # xmake
      tboox.xmake-vscode

      # makefile
      ms-vscode.makefile-tools

      # cpp
      xaver.clang-format
      vadimcn.vscode-lldb
      llvm-vs-code-extensions.vsode-clangd

      # nuxt
      nuxtr.nuxtr-vscode

      # rust
      rust-lang.rust-analyzer

      # misc
      aaron-bond.better-comments                          # better comments
      tomoki1207.vscode-pdf                               # pdf
      zh9528.file-size                                    # file-size
      wakatime.vscode-wakatime                            # wakatime
      editorconfig.editorconfig                           # editorconfig
      chrmarti.regex                                      # regex check / preview
      pnp.polacode                                        # polacode
      mikestead.dotenv                                    # dotenv file
      ultram4rine.vscode-choosealicense                   # choose a license
      w88975.code-translate                               # code translate
      streetsidesoftware.code-spell-checker               # cspell
      usernamehw.errorlens                                # error lens
      afzalsayed96.icones                                 # icon search
      jock.svg                                            # svg preview
      antfu.slidev                                        # slidev
      antfu.iconify                                       # iconify preview
      cschlosser.doxdocgen                                # doxygen
      redhat.vsocde-commons                               # redhat extension commons
      visualstudioexptteam.intellicode-api-usage-examples # vscode offical lsp extension commons
      visualstudioexptteam.vscodeintelligenicode          # vscode offical lsp extension commons
      kisstkondoros.vscode-gutter-preview                 # image preview
      vsls-contrib.gistfs                                 # github gist files
      peterschmalfeldt.explorer-exclude                   # file / folder explorer exclude
      naumovs.color-highlight                             # color highlight
      oderwat.indent-rainbow                              # indent rainbow
      vincaslt.highlight-matching-tag                     # highlight matching tag
    ];
  };
}

