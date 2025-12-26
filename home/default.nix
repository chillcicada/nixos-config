{ inputs, ... }:

{
  # This configuration is designed for graphical usage (`desktop.enable = true`).
  imports = [
    # Software enabled by default
    ./apps
    # Modules for the desktop environment
    ./modules
    # Common configurations with Minimal configurations
    ./common.nix
  ];

  # Add nixpkgs overlays
  nixpkgs.overlays = [
    inputs.chillcicada.overlays.default
    (_: super: {
      wechat = super.wechat.overrideAttrs (_: {
        src = super.fetchurl {
          url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
          hash = "sha256-+r5Ebu40GVGG2m2lmCFQ/JkiDsN/u7XEtnLrB98602w=";
        };
      });
    })
  ];
}
