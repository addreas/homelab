{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  networking.hostName = "nucle5";

  services.kubeadm.init.enable = true;
  services.kubeadm.init.bootstrapTokenFile = "/var/secret/kubeadm-bootstrap-token"; 
}

