{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    ./minimal.nix
    # ./sd-image.nix
    ./rockchip.nix
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "arm-trusted-firmware-rk3399" ];

  boot.initrd.kernelModules = [
    "rockchip_rga"
    "rockchip_saradc"
    "rockchip_thermal"
    "rockchipdrm"
  ];

  boot.kernelParams = [
    "earlycon"
    "console=tty0"
    "console=ttyFIQ0,1500000n8"
    "console=ttyAML0,115200n8"
    "console=ttyS2,1500000n8"
    "console=ttyS0,1500000n8"
    "coherent_pool=2M"
    "irqchip.gicv3_pseudo_nmi=0"
  ];

  # hardware.enableRedistributableFirmware = true;
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "24.05";
  security.sudo.wheelNeedsPassword = false;

  fileSystems."/mnt/data" = {
    # sudo mkfs.btrfs -L data -d raid1 -m raid1 /dev/sd{a,b}
    device = "/dev/disk/by-label/data";
    fsType = "btrfs";
    options = [ "discard" "nofail" ];
  };

  services.btrbk.sshAccess = [
    # sudo ssh-keygen -t ed25519 -C btrbk@$(hostname) -f /var/lib/btrbk/.ssh/id_ed25519
    {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIADZ5vt0pXC+gJt2bxEJhuWvyres31EuEqN5WsXvMJ6c btrbk@sergio";
      roles = [ "info" "target" "delete" ];
    }
  ];

}
