{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  networking.hostName = "nucle4";
  services.tailscale.enable = true;

  systemd.network.networks."10-lan" = {
    matchConfig.Name = "eno1";
    networkConfig.DHCP = "ipv4";
    linkConfig.RequiredForOnline = "routable";
    address = [ "192.168.0.192/32" ];
  };

  networking.hosts = {
    "192.168.0.192" = ["nucle4.localdomain" "nucles.localdomain"];
  };
}

