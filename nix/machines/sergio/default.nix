# parted /dev/sda -- mklabel gpt
# parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
# parted /dev/sda -- mkpart OS btrfs 512MiB 100%
# parted /dev/sda -- set 1 esp on

# mkfs.fat -F 32 -n boot /dev/sda1
# mkfs.btrfs -L OS /dev/sda2

# nixos-generate-config --root /mnt
# nixos-install
# reboot

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{


  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nas.nix
    ./monitoring.nix
    ./kube.nix
  ];
  swapDevices = [ ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = false;

  # boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  # boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  system.autoUpgrade = {
    enable = true;
    flake = "/home/addem/github.com/addreas/homelab";
    flags = [ "--update-input" "nixpkgs" ];
    operation = "boot";
  };
  systemd.services."nixos-upgrade".serviceConfig.ExecStartPre = pkgs.writeShellScript "flake-pull" ''
    cd /home/addem/github.com/addreas/homelab
    ${pkgs.sudo}/bin/sudo -u addem ${pkgs.git}/bin/git pull
  '';
  systemd.services."nixos-upgrade".serviceConfig.ExecStartPost = pkgs.writeShellScript "flake-push" ''
    cd /home/addem/github.com/addreas/homelab
    ${pkgs.sudo}/bin/sudo -u addem ${pkgs.git}/bin/git commit -am "flake update"
    ${pkgs.sudo}/bin/sudo -u addem ${pkgs.git}/bin/git push
  '';

  # requires manual `sudo btrfs subvolume create /.snapshots`
  # services.snapper.snapshotRootOnBoot = true;
  # services.snapper.configs.root.subvolume = "/";
  # services.snapper.configs.root.extraConfig = ''
  #   NUMBER_CLEANUP=yes
  #   NUMBER_LIMIT=10
  #   '';
  # services.locate.prunePaths = ["./snapshots"];

  networking.hostName = "sergio";
  networking.domain = "localdomain";

  systemd.network.enable = true;
  systemd.network.networks.lan.name = "eno1";
  # systemd.network.networks.lan.dns = ["192.168.1.1"];
  systemd.network.networks.lan.DHCP = "yes";
  networking.dhcpcd.enable = false;
  services.resolved.dnssec = "false"; # dnssec fails for localdomain and breaks stuff
  networking.dhcpcd.allowInterfaces = [ "eno1" ];
  systemd.network.wait-online.anyInterface = true;

  # services.tailscale.enable = true;

  virtualisation.podman.enable = true;
  virtualisation.oci-containers.backend = "podman";

  services.harmonia = {
    enable = true;
    settings = {
      bind = "[::]:9723";
      sign_key_path = "/var/secret/local-nix-secret-key";
    };
  };

  users.users.harmonia = {
    uid = 991;
    isSystemUser = true;
    group = "harmonia";
  };
  users.groups.harmonia.gid = 987;

  # networking.firewall.enable = false;
  networking.firewall.logReversePathDrops = true;
  # networking.firewall.logRefusedPackets = true;
  # networking.firewall.logRefusedUnicastsOnly = true;

  networking.firewall.checkReversePath = false; # even loose breaks kube-dns responses

  networking.firewall.allowedTCPPorts = [
    22
    80
    443

    9723 # harmonia

    9000 #minio
    9001 #minio

    3005 # plex
    8324 # plex
    32400 # plex
    32469 # plex
  ];
  networking.firewall.allowedUDPPorts = [
    1900 # upnp / ssdp (plex)
    5353 # mdns (plex)

    32410 # plex
    32412 # plex
    32413 # plex
    32414 # plex
  ];
}

