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
        # Until https://github.com/util-linux/util-linux/issues/3474 is available in a nixpkgs-unstable
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/ut/util-linux/package.nix
        # util-linux
        (util-linux.overrideAttrs {
          patches = util-linux.patches ++ [
            (fetchpatch {
              url = "https://github.com/util-linux/util-linux/commit/7dbfe31a83f45d5aef2b508697e9511c569ffbc8.patch";
              hash = "sha256-bJqpZiPli5Pm/XpDA445Ab5jesXrlcnaO6e4V0B3rSw=";
              name = "fix-libmount-regression.patch";
            })
          ];
        })
        iproute2
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
