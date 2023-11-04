{ pkgs, config, ... }: {
  imports = [
    ../nucles/kube.nix
  ];

  services.kubeadm = {
    controlPlane = true;
    # init = {
    # enable = true;
    # bootstrapTokenFile = "/var/secret/kube-bootstrap-token";
    # certificateKeyFile = "/var/secret/kube-certificate-key";
    # };
  };

  environment.systemPackages = [ pkgs.etcd ];
  environment.sessionVariables = {
    "ETCDCTL_CERT" = "/etc/kubernetes/pki/etcd/server.crt";
    "ETCDCTL_KEY" = "/etc/kubernetes/pki/etcd/server.key";
    "ETCDCTL_CACERT" = "/etc/kubernetes/pki/etcd/ca.crt";
  };
}
