{ config, pkgs, lib, ... }:
{
  system.stateVersion = "24.05";
  security.sudo.wheelNeedsPassword = false;

  # fileSystems."/mnt/data" = {
  #   device = "/dev/disk/by-uuid/<todo>";
  #   fsType = "btrfs";
  #   options = [ "discard" "nofail" ];
  # }

  services.btrbk.sshAccess = [
    # sudo ssh-keygen -t ed25519 -C btrbk@$(hostname) -f /var/lib/btrbk/.ssh/id_ed25519
    { key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIADZ5vt0pXC+gJt2bxEJhuWvyres31EuEqN5WsXvMJ6c btrbk@sergio"; }
  ]
}
