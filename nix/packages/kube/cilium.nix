{ ... }: {
  config = {

    # https://docs.cilium.io/en/latest/operations/system_requirements/#firewall-rules
    networking.firewall.allowedTCPPorts = [
      4240
      4244
      4245

      9962
      9963
      9964

      51871
    ];

    networking.firewall.allowedUDPPorts = [ 8472 ];

    systemd.network.config.networkConfig.ManageForeignRoutingPolicyRules = false;
  };
}
