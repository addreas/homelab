{ pkgs, lib, config, ... }:
let
  cfg = config.services.nas;

  getEnabled = type: shares: lib.attrsets.filterAttrs (name: share: share.${type}.enable) shares;
  yesno = pred: if pred then "yes" else "no";

  mkNFS = shares: builtins.concatStringsSep "\n" (map mkNFSShare (builtins.attrValues (getEnabled "nfs" shares)));
  mkNFSShare = share: "${share.path} ${builtins.concatStringsSep " " (builtins.map (conf: "${conf.clients}(${builtins.concatStringsSep "," conf.options})") share.nfs.configs)}";

  mkSMB = shares: builtins.mapAttrs mkSMBShare (getEnabled "smb" shares);
  mkSMBShare = name: share: {
    "path" = share.path;
    "read only" = yesno share.smb.readonly;
    "browseable" = yesno share.smb.browseable;
    "guest ok" = yesno share.smb.guest;
    "admin users" = builtins.concatStringsSep " " share.smb.admins;
  };

  mkAFSShare = name: share: {
    "path" = share.path;
    "time machine" = yesno share.afs.timemachine;
  };
  mkAFS = shares: builtins.mapAttrs mkAFSShare (getEnabled "afs" shares);

  mkSubmodule = options: lib.mkOption { type = lib.types.submodule { inherit options; }; };
in
{
  options.services.nas = with lib; {
    enable = mkEnableOption "NAS";

    shares = mkOption {
      type = with types; attrsOf (submodule {
        options = {
          path = mkOption { type = str; };

          # device/mount stuff?
          # backup stuff?

          nfs = mkSubmodule {
            enable = mkEnableOption "Enable NFS for this share";

            configs = mkOption {
              type = listOf (submodule {
                options = {
                  clients = mkOption { type = str; };
                  options = mkOption {
                    type = listOf str;
                    default = ["rw" "sync" "all_squash"];
                  };
                };
              });
              default = [{ clients = "*"; }];
            };
          };

          smb = mkSubmodule {
            enable = mkEnableOption "Enable SMB for this share";
            readonly = mkEnableOption "readonly";
            browseable = mkEnableOption "browseable";
            guest = mkEnableOption "guest ok";
            admins = mkOption { type = listOf str; default = []; };
          };

          afs = mkSubmodule {
            enable = mkEnableOption "Enable AFS for this share";
            timemachine = mkEnableOption "Enable Time Machine for this share";
          };

        };
      });
    };
  };

  config = lib.mkIf cfg.enable {

    services.rpcbind.enable = lib.mkDefault true;
    services.nfs.server.enable = lib.mkDefault true;
    services.nfs.server.statdPort = lib.mkDefault 4000;
    services.nfs.server.lockdPort = lib.mkDefault 4001;
    services.nfs.server.mountdPort = lib.mkDefault 4002;
    services.nfs.server.exports = mkNFS cfg.shares;

    services.samba.enable = true;
    services.samba-wsdd.enable = true;
    services.samba.openFirewall = true;
    services.samba.settings = {
      global = {
        "guest account" = "nobody";
        "map to guest" = "Bad User";
        "unix password sync" = "no";
      };
    } // mkSMB cfg.shares;

    # setup smb passwords separately with 
    # sudo smbpasswd -a <username>

    services.netatalk.enable = true;
    services.netatalk.settings = mkAFS cfg.shares;

    # services.btrfs.autoScrub.enable = true;
    # services.btrfs.autoScrub.fileSystems = [ "/" "/mnt/data" ];
    #
    # services.btrbk.instances.btrbk.onCalendar = "hourly";
    # services.btrbk.instances.btrbk.settings = {
    #   snapshot_preserve_min = "1d";

    #   target_preserve_min = "1d";
    #   target_preserve = "30d";

    #   snapshot_dir = ".snapshots";
    #   snapshot_create = "onchange";

    #   ssh_user = "btrbk";

    #   volume = {
    #     "/mnt/data" = {
    #       target = {
    #         "ssh://pinas.localdomain/mnt/data/sergio/mnt/data" = { };
    #         # "ssh://radnas.localdomain/mnt/data/sergio/mnt/data" = { };
    #       };
    #       subvolume = {
    #         "pictures" = { };
    #         "backups" = { };
    #         "longhorn-backup" = { };
    #       };
    #     };

    #     "/mnt/solid-data" = {
    #       target = {
    #         "ssh://pinas.localdomain/mnt/data/sergio/mnt/solid-data" = { };
    #         # "ssh://radnas.localdomain/mnt/data/sergio/mnt/solid-data" = { };
    #       };
    #       subvolume = {
    #         "victoriametrics" = { };
    #         "loki" = { };
    #         "plex-config" = { };
    #         "sonarr-config" = { };
    #         "radarr-config" = { };
    #         "jackett-config" = { };
    #       };
    #     };
    #   };
    # };

    networking.firewall.allowedTCPPorts = [
      111 # rpcbind
      139 # smbd // covered by services.samba.enable?
      445 # smbd // covered by services.samba.enable?

      548 # netatalk afpd
      5357 # services.samba-wsdd

      2049 # nfs
      4000 # nfs statd
      4001 # nfs lockd
      4002 # nfs mountd
    ];
    networking.firewall.allowedUDPPorts = [
      3702 # services.samba-wsdd // covered by services.samba.enable?
    ];

  };

}
