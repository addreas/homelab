# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "mpt3sas" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "UUID=43fbc380-3f3a-4aab-8612-212b13f7eb61";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/boot" =
    {
      device = "UUID=5863-AEAE";
      fsType = "vfat";
    };

  fileSystems."/home" =
    {
      device = "UUID=43fbc380-3f3a-4aab-8612-212b13f7eb61";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/nix" =
    {
      device = "UUID=43fbc380-3f3a-4aab-8612-212b13f7eb61";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."/var/lib" =
    {
      device = "UUID=43fbc380-3f3a-4aab-8612-212b13f7eb61";
      fsType = "btrfs";
      options = [ "subvol=@varlib" ];
    };

  fileSystems."/var/log" =
    {
      device = "UUID=43fbc380-3f3a-4aab-8612-212b13f7eb61";
      fsType = "btrfs";
      options = [ "subvol=@varlog" ];
    };

  fileSystems."/var/lib/longhorn" =
    {
      device = "UUID=ff765678-1e5a-4496-aa0c-0f763dc6c9b1";
      fsType = "ext4";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.cni-podman0.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
  # networking.interfaces.veth59feaf4b.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
