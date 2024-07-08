{ pkgs, lib, config, ... }:
{
  options.services.kubeadm.init = with lib; {
    enable = mkEnableOption "kubeadm init";

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

  config.services.kubeadm.init = {
    initConfig.apiVersion = "kubeadm.k8s.io/v1beta4";
    initConfig.kind = "InitConfiguration";

    clusterConfig.apiVersion = "kubeadm.k8s.io/v1beta4";
    clusterConfig.kind = "ClusterConfiguration";

    kubeletConfig.apiVersion = "kubelet.config.k8s.io/v1beta1";
    kubeletConfig.kind = "KubeletConfiguration";

    kubeProxyConfig.apiVersion = "kubeproxy.config.k8s.io/v1alpha1";
    kubeProxyConfig.kind = "KubeProxyConfiguration";
  };

  config.services.kubeadm.upgrade = {
    upgradeConfig.apiVersion = "kubeadm.k8s.io/v1beta4";
    upgradeConfig.kind = "UpgradeConfiguration";
    upgradeConfig.apply.forceUpgrade = true; # non-interactive upgrade is required
  };
}
