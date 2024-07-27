{ config, pkgs, lib, ... }:
{
  system.stateVersion = "24.05";
  security.sudo.wheelNeedsPassword = false;

  services.tailscale.enable = true;

  fileSystems."/mnt/data" = {
    # sudo mkfs.btrfs -L data -d raid1 -m raid1 /dev/nvme{0,1}n1
    device = "/dev/disk/by-label/data";
    fsType = "btrfs";
    options = [ "discard" "nofail" ];
  };

  environment.systemPackages = with pkgs; [ btrfs-progs ];

  services.btrbk.sshAccess = [
    # sudo ssh-keygen -t ed25519 -C btrbk@$(hostname) -f /var/lib/btrbk/.ssh/id_ed25519
    {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIADZ5vt0pXC+gJt2bxEJhuWvyres31EuEqN5WsXvMJ6c btrbk@sergio";
      roles = [ "info" "target" "delete" ];
    }
  ];
}
