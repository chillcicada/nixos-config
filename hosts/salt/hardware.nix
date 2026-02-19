{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/minimal.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.loader.grub.device = "/dev/vda";

  boot.initrd.systemd.enable = true;

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "xen_blkfront"
    "vmw_pvscsi"
  ];
  boot.initrd.kernelModules = [ "nvme" ];

  services.userborn.enable = true;
  system.etc.overlay.enable = true;

  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };
}
