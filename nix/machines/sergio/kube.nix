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
    "ETCDCTL_API" = "3";
  };
}
