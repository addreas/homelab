{ pkgs, lib, config, ... }:
let
  cfg = config.services.kubeadm;

  kubeadmInitConfig = pkgs.writeText "kubeadm-init.yaml" (
    lib.strings.concatMapStringsSep
      "\n---\n"
      builtins.toJSON
      [
        cfg.init.initConfig
        cfg.init.clusterConfig
        cfg.init.kubeletConfig
        cfg.init.kubeProxyConfig
      ]
  );

  kubeadmUpgradeConfig = pkgs.writeText "kubeadm-upgrade.yaml" (
    builtins.toJSON
      cfg.upgrade.upgradeConfig
  );
in
{
  imports = [
    ./config.nix
    ./kubelet.nix
  ];

  options.services.kubeadm = {
    enable = lib.mkEnableOption "kubeadm";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.kubernetes;
    };
    controlPlane = lib.mkEnableOption "control plane";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelModules = [ "br_netfilter" ];

    boot.kernel.sysctl = {
      # idk why i have these
      # "net.bridge.bridge-nf-call-iptables" = 1;
      # "net.bridge.bridge-nf-call-ip6tables" = 1;
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    # systemd.tmpfiles.rules = [
    #   "d /opt/cni/bin 0755 root root -"
    #   "d /run/kubernetes 0755 kubernetes kubernetes -"
    #   "d /var/lib/kubernetes 0755 kubernetes kubernetes -"
    # ];

    networking.firewall.allowedTCPPorts = [
      10250
    ] ++ (if !cfg.controlPlane then [ ] else [
      6443
      2379
      2380
      10259
      10257
    ]);
    networking.firewall.allowedTCPPortRanges = [{ from = 30000; to = 32767; }];

    systemd.services.kubeadm-init = lib.mkIf (cfg.init.enable && cfg.controlPlane) {
      description = "kubeadm init";

      path = with pkgs; [
        gitMinimal
        openssh
        docker
        utillinux
        iproute
        ethtool
        thin-provisioning-tools
        iptables
        nftables
        socat
        cni
        cri-tools
        conntrack-tools
        cfg.package
      ];

      serviceConfig.Type = "oneshot";
      unitConfig.ConditionPathExists = "!/etc/kubernetes";

      script = ''
        if ! ${pkgs.curl}/bin/curl --insecure https://${cfg.init.clusterConfig.controlPlaneEndpoint}; then
          ${cfg.package}/bin/kubeadm init --config ${kubeadmInitConfig}
        fi
      '';

      wantedBy = [ "kubelet.service" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
    };

    systemd.services.kubeadm-join = lib.mkIf cfg.init.enable {
      description = "kubeadm join";

      path = with pkgs; [
        gitMinimal
        openssh
        docker
        utillinux
        iproute
        ethtool
        thin-provisioning-tools
        iptables
        nftables
        socat
        cni
        cri-tools
        conntrack-tools
        cfg.package
      ];

      serviceConfig = {
        Type = "oneshot";
        ExecCondition = "${pkgs.curl}/bin/curl --insecure https://${cfg.init.clusterConfig.controlPlaneEndpoint}";
      };
      unitConfig.ConditionPathExists = "!/etc/kubernetes/.kubeadm-joined";

      script = ''
        ${cfg.package}/bin/kubeadm join ${cfg.init.clusterConfig.controlPlaneEndpoint} \
          --v=5 \
          --token $(cat ${cfg.init.bootstrapTokenFile}) \
          --discovery-token-unsafe-skip-ca-verification \
          ${lib.strings.optionalString (cfg.controlPlane) ''
            --control-plane \
            --certificate-key $(cat ${cfg.init.certificateKeyFile})
            ''}


        rm ${cfg.init.bootstrapTokenFile} ${lib.strings.optionalString cfg.controlPlane cfg.init.certificateKeyFile}
        touch /etc/kubernetes/.kubeadm-joined
      '';

      wantedBy = [ "kubelet.service" ];
      after = [ "network-online.target" ] ++ (lib.lists.optionals cfg.controlPlane [ "kubeadm-init.service" ]);
      wants = [ "network-online.target" ];
    };


    systemd.services.kubeadm-upgrade = lib.mkIf cfg.upgrade.enable {
      description = "kubeadm upgrade";

      path = with pkgs; [
        gitMinimal
        openssh
        docker
        utillinux
        iproute
        ethtool
        thin-provisioning-tools
        iptables
        nftables
        socat
        cni
        cri-tools
        conntrack-tools
        cfg.package
      ];

      serviceConfig.Type = "oneshot";
      unitConfig.ConditionPathExists = "/etc/kubernetes";

      script =
        let
          kubeadm = "${cfg.package}/bin/kubeadm";
          kubectl = "${cfg.package}/bin/kubectl";
          kubectl-get-kubeadm-target-version = ''
            ${kubectl} get configmap kubeadm-config \
              --kubeconfig /etc/kubernetes/admin.conf \
              --namespace kube-system \
              -o jsonpath='{.data.ClusterConfiguration}' \
              | grep kubernetesVersion \
              | cut -d" " -f2
          '';
        in
        if cfg.controlPlane
        then ''
          until ${pkgs.curl}/bin/curl -sS --insecure https://${cfg.init.clusterConfig.controlPlaneEndpoint}; do
            sleep 1
          done

          KUBEADM_CONFIG_TARGET_VERSION=$(${kubectl-get-kubeadm-target-version})
          KUBEADM_CLI_VERSION=$(${kubeadm} version -o short)
          KUBE_APISERVER_MANIFEST_VERSION=$(cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep image: | cut -d: -f3)
          if [[ "$KUBEADM_CONFIG_TARGET_VERSION" != "$KUBEADM_CLI_VERSION" ]]; then
              ${kubeadm} upgrade plan $KUBEADM_CLI_VERSION --config ${kubeadmUpgradeConfig} \
                && ${kubeadm} upgrade apply $KUBEADM_CLI_VERSION --config ${kubeadmUpgradeConfig}
          else
              ${kubeadm} upgrade node --config ${kubeadmUpgradeConfig}
          fi
        ''
        else ''
          ${kubeadm} upgrade node --config ${kubeadmUpgradeConfig}
        '';

      wantedBy = [ "kubelet.service" ];
      after = [ "network-online.target" "kubelet.service" "crio.service" ];
      wants = [ "network-online.target" ];
    };

  };
}
