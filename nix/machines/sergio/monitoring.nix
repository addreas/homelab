{ ... }:
{
  services.smartd.enable = true;
  services.smartd.notifications.mail.enable = true;
  # services.prometheus.exporters.smartctl.enable = true;
  # services.prometheus.exporters.smartctl.openFirewall = true;
  # systemd.services."prometheus-smartctl-exporter".serviceConfig.DeviceAllow =
  #   [ "block-blkext rw" "block-sd rw" "char-nvme rw" ];

  # power.ups.enable = true;
  # power.ups.mode = "netserver";
  # power.ups.ups.ups = {
  #   port = "auto";
  #   driver = "usbhid-ups";
  # };

  # environment.etc = {
  #   "nut/upsd.conf".text = "LISTEN 0.0.0.0";
  #   "nut/upsd.users".text = ''
  #     [monuser]
  #     upsmon master
  #     password = "monuser"
  #   '';
  #   "nut/upsmon.conf".text = ''
  #     MONITOR ups@localhost 1 monuser "monuser" master
  #   '';
  # };

  # system.activationScripts.var-lib-nut = "mkdir -p /var/lib/nut; chmod o-r /var/lib/nut";

  #services.apcupsd.enable = true;
  #services.prometheus.exporters.apcupsd.enable = true;
  # power.ups.ups.ups = {
  #   port = "localhost";
  #   driver = "apcupsd-ups";
  # };

  networking.firewall.allowedTCPPorts = [
    # 3493 # nut/upsd
    # 3100 # loki
    9633 # smartctl exporter
    9100 # node exporter
  ];
}
