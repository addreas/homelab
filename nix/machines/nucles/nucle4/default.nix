{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  networking.hostName = "nucle4";

  services.tailscale.enable = true;

  services.kubeadm.controlPlane.enable = true;
  services.kubeadm.controlPlane.advertiseAddress = "100.65.139.71";

  environment.systemPackages = [ pkgs.etcd ];
  environment.sessionVariables = {
    "ETCDCTL_CERT" = "/etc/kubernetes/pki/etcd/server.crt";
    "ETCDCTL_KEY" = "/etc/kubernetes/pki/etcd/server.key";
    "ETCDCTL_CACERT" = "/etc/kubernetes/pki/etcd/ca.crt";
  };
}

