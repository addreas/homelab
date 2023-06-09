{ pkgs, ... }:
let
  hosts = [
    "sergio.localdomain"
    "nucles.localdomain"
    "nucle1.localdomain"
    "nucle2.localdomain"
    "nucle3.localdomain"
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

    init.initConfig = { };

    init.clusterConfig = {
      clusterName = "nucles";
      apiServer = {
        certSANs = hosts;
        extraArgs.feature-gates = "MixedProtocolLBService=true";
      };
      controllerManager.extraArgs.bind-address = "0.0.0.0";
      scheduler.extraArgs.bind-address = "0.0.0.0";
      controlPlaneEndpoint = "nucles.localdomain:6443";
    };

    init.kubeletConfig = {
      serializeImagePulls = false;
      allowedUnsafeSysctls = [ "net.ipv4.conf.all.src_valid_mark" ];
      shutdownGracePeriod = "5m";
      shutdownGracePeriodCriticalPods = "1m";
    };
  };

  environment.systemPackages = [ pkgs.kubernetes ];
}
