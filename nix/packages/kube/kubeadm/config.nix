{ pkgs, lib, config, ... }:
let
  cfg = config.services.kubeadm;
in
{
  options.services.kubeadm = with lib; {
    enableInit = mkEnableOption "kubeadm init";

    bootstrapTokenFile = mkOption {
      type = types.path;
      description = "Should contain the output from `kubeadm token create`";
    };
    certificateKeyFile = mkOption {
      type = types.path;
      description = "Should contain the output from `kubeadm init phase upload-certs --upload-certs`";
    };

    initConfig = mkOption {
      type = types.attrs;
      description = "https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta4/#kubeadm-k8s-io-v1beta4-InitConfiguration";
    };

    joinConfig = mkOption {
      type = types.attrs;
      description = "https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta4/#kubeadm-k8s-io-v1beta4-JoinConfiguration";
    };

    clusterConfig = mkOption {
      type = types.attrs;
      description = "https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta4/#kubeadm-k8s-io-v1beta4-ClusterConfiguration";
    };

    kubeletConfig = mkOption {
      type = types.attrs;
      description = "https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1/#kubelet-config-k8s-io-v1beta1-KubeletConfiguration";
    };

    kubeProxyConfig = mkOption {
      type = types.attrs;
      description = "https://kubernetes.io/docs/reference/config-api/kube-proxy-config.v1alpha1/#kubeproxy-config-k8s-io-v1alpha1-KubeProxyConfiguration";
    };
  };

  options.services.kubeadm.upgrade = with lib; {
    enable = mkEnableOption "kubeadm upgrade";

    upgradeConfig = mkOption {
      type = types.attrs;
      description = "https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta4/#kubeadm-k8s-io-v1beta4-UpgradeConfiguration";
    };
  };

  config.services.kubeadm = {
    initConfig.apiVersion = "kubeadm.k8s.io/v1beta4";
    initConfig.kind = "InitConfiguration";
    initConfig.localAPIEndpoint.advertiseAddress = cfg.controlPlane.advertiseAddress;

    joinConfig.apiVersion = "kubeadm.k8s.io/v1beta4";
    joinConfig.kind = "JoinConfiguration";

    joinConfig.discovery.bootstrapToken.apiServerEndpoint = cfg.clusterConfig.controlPlaneEndpoint;
    joinConfig.discovery.bootstrapToken.token = cfg.bootstrapTokenFile;

    joinConfig.controlPlane.localAPIEndpoint.advertiseAddress = cfg.controlPlane.advertiseAddress;
    joinConfig.controlPlane.certificateKey = cfg.certificateKeyFile;

    clusterConfig.apiVersion = "kubeadm.k8s.io/v1beta4";
    clusterConfig.kind = "ClusterConfiguration";

    kubeletConfig.apiVersion = "kubelet.config.k8s.io/v1beta1";
    kubeletConfig.kind = "KubeletConfiguration";

    kubeProxyConfig.apiVersion = "kubeproxy.config.k8s.io/v1alpha1";
    kubeProxyConfig.kind = "KubeProxyConfiguration";

    upgradeConfig.apiVersion = "kubeadm.k8s.io/v1beta4";
    upgradeConfig.kind = "UpgradeConfiguration";
    upgradeConfig.apply.forceUpgrade = true; # non-interactive upgrade is required
  };
}
