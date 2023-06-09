{ pkgs, lib, config, ... }:
let
  cfg = config.services.kubeadm;
in
{
  options.services.kubeadm.kubelet = {
    enable = lib.mkEnableOption "kubelet";
  };

  config = lib.mkIf cfg.kubelet.enable {
    systemd.services.kubelet = {
      description = "Kubernetes Kubelet Service";
      wantedBy = [ "multi-user.target" ];
      after = [ "crio.service" ];

      path = with pkgs; [
        gitMinimal
        openssh
        docker
        utillinux
        iproute
        ethtool
        thin-provisioning-tools
        iptables
        socat
        cni
      ];

      unitConfig.StartLimitInterval = 0;
      serviceConfig = {
        Slice = "kubernetes.slice";
        CPUAccounting = true;
        MemoryAccounting = true;

        StateDirectory = "kubelet";
        ConfigurationDirectory = "kubernetes";

        EnvironmentFile = "-/var/lib/kubelet/kubeadm-flags.env";

        Restart = "always";
        RestartSec = 10;

        ExecStart = ''
          ${cfg.package}/bin/kubelet \
            --kubeconfig=/etc/kubernetes/kubelet.conf \
            --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf \
            --config=/var/lib/kubelet/config.yaml \
            --node-labels=nucles.addem.se/os=nixos \
            $KUBELET_KUBEADM_ARGS
        '';
      };
    };
  };
}
