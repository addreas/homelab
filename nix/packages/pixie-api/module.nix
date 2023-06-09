{ pkgs, lib, config, ... }:
let
  cfg = config.services.pixiecore-host-configs;

  api-ts = pkgs.writeText "api.ts" (builtins.readFile ./api.ts);

  host-configs = pkgs.writeText "host-configs.json" (builtins.toJSON (lib.attrsets.mapAttrs mkPixiecoreConfig cfg.hosts));

  mkPixiecoreConfig = mac: host: {
    kernel = "file://${host.nixosSystem.config.system.build.kernel}/bzImage";
    initrd = [ "file://${host.nixosSystem.config.system.build.netbootRamdisk}/initrd" ];
    # pixiecore appends initrd kernel args
    cmdline = builtins.concatStringsSep " " (builtins.concatLists [
      [
        "init=${host.nixosSystem.config.system.build.toplevel}/init"
        "pixie-api=http://${config.networking.fqdn}:${builtins.toString cfg.port}"
        # TODO: serve nuke.sh from instead of baking into nucle-installer
        "mac=${mac}"
      ]
      host.kernelParams
    ]);
  };
in
{
  options.services.pixiecore-host-configs = {
    enable = lib.mkEnableOption "pixiecore-host-configs";
    port = lib.mkOption {
      default = 9813;
      type = lib.types.int;
    };
    github-client-id = lib.mkOption {
      default = "01ca7d6823ac66b96743";
      type = lib.types.str;
    };
    hosts = lib.mkOption {
      type = with lib.types; attrsOf (submodule {
        options = {
          nixosSystem = lib.mkOption { type = attrs; };
          kernelParams = lib.mkOption { type = listOf str; default = [ ]; };
        };
      });
    };
  };

  config = lib.mkIf cfg.enable {
    services.pixiecore = {
      enable = true;
      mode = "api";
      apiServer = "http://localhost:${builtins.toString cfg.port}";
      openFirewall = true; #incorrectly opens 4011 on TCP
      dhcpNoBind = true;
    };

    networking.firewall.allowedTCPPorts = [ cfg.port ];
    networking.firewall.allowedUDPPorts = [ 4011 ];

    systemd.services.pixiecore-host-configs = {
      description = "Pixiecore API mode responder";
      wantedBy = [ "pixiecore.service" ];

      serviceConfig = {
        Restart = "always";
        RestartSec = 10;

        ExecStart = lib.strings.concatStringsSep " " [
          "${pkgs.deno}/bin/deno"
          "run"
          "--allow-net"
          "--allow-read"
          "--allow-write=/tmp/pixie-api"
          "${api-ts}"
          "--port=${builtins.toString cfg.port}"
          "--host=0.0.0.0"
          "--configs=${host-configs}"
          "--persist=/tmp/pixie-api"
          "--github-client-id=${cfg.github-client-id}"
        ];
      };
    };
  };

}
