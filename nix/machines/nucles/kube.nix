{ pkgs, ... }:
let
  hosts = [
    "sergio.localdomain"
    "nucles.localdomain"
  ];
in
{
  imports = [
    ../../packages/kube
  ];

  services.kubeadm = {
    enable = true;
    package = pkgs.kubernetes;
    kubelet.enable = true;

    init.initConfig = {};

    init.clusterConfig = {
      clusterName = "nucles";

      controlPlaneEndpoint = "nucles.localdomain:6443";

      apiServer.certSANs = hosts;

      proxy.disabled = true;

      controllerManager.extraArgs = [{
        name = "bind-address";
        value = "0.0.0.0";
      }];

      scheduler.extraArgs = [{
        name = "bind-address";
        value = "0.0.0.0";
      }];
    };

    init.kubeletConfig = {
      serializeImagePulls = false;
      allowedUnsafeSysctls = [ "net.ipv4.conf.all.src_valid_mark" ];
      shutdownGracePeriod = "5m";
      shutdownGracePeriodCriticalPods = "1m";
      cpuCFSQuota = false;
    };

    upgrade.enable = true;
    upgrade.upgradeConfig = {};
  };

  environment.systemPackages = [ pkgs.kubernetes ];
}
