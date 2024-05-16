{ pkgs, config, ... }: {
  imports = [
    ./crio.nix
    ./cilium.nix
    ./kured.nix
    ./kubeadm
  ];

  config = {
    environment.systemPackages = with pkgs; [
      openiscsi
      nfs-utils
    ];

    services.openiscsi.enable = true;
    services.openiscsi.name = "iqn.2023-01.se.addem.nucles:${config.networking.hostName}";

    networking.firewall.enable = false;
    networking.firewall.logRefusedPackets = true;

    networking.firewall.checkReversePath = false; # even loose breaks kube-dns responses
    networking.firewall.allowedUDPPorts = [
      53 # routing kube dns responses
    ];

    networking.firewall.allowedTCPPorts = [
      179 # bgp

      9100 # node-exporter
      9633 # smartctl-exporter
    ];

    systemd.sockets.cni-dhcp = {
      description = "CNI DHCP service socket";
      documentation = [ "https://github.com/containernetworking/plugins/tree/master/plugins/ipam/dhcp" ];
      partOf = [ "chi-dhcp.service" ];

      socketConfig = {
        ListenStream = "/run/cni/dhcp.sock";
        SocketMode = "0660";
        SocketUser = "root";
        SocketGroup = "root";
        RemoveOnStop = true;
      };

      wantedBy = [ "sockets.target" ];
    };

    systemd.services.cni-dhcp = {
      description = "CNI DHCP service";
      documentation = [ "https://github.com/containernetworking/plugins/tree/master/plugins/ipam/dhcp" ];
      after = [ "network.target" "cni-dhcp.socket" ];
      requires = [ "cni-dhcp.socket" ];

      serviceConfig.ExecStart = "${pkgs.cni-plugins}/bin/dhcp daemon";

      wantedBy = [ "multi-user.target" ];
    };
  };
}
