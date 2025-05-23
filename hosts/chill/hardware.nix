{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/69161400-ec5c-40ee-b170-1a65e9ecb18f";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-7c3b0330-9fe7-4f85-9d7d-a06111a12360".device =
    "/dev/disk/by-uuid/7c3b0330-9fe7-4f85-9d7d-a06111a12360";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F8E4-45D4";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/732c80a8-9628-4f9f-ae53-a82ec8565e53"; } ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
