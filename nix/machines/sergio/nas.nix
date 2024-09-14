{ config, lib, pkgs, modulesPath, ... }:

let
  bind = source: subpath: {
    depends = [ source ];
    device = "${source}/${subpath}";
    fsType = "none";
    options = [ "bind" "nofail" ];
  };
in
{
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/d5f05d68-2761-4262-af48-af7b221daea5";
    fsType = "btrfs";
    options = [ "nofail" ];
  };
  fileSystems."/mnt/solid-data" = {
    device = "/dev/disk/by-uuid/b6df7c6f-d5fd-4f14-b02c-d57727db5a23";
    fsType = "btrfs";
    options = [ "nofail" "discard" ];
  };
  fileSystems."/mnt/plex-config" = {
    device = "/dev/disk/by-uuid/660b83df-c44d-4265-b293-272127aabf22";
    fsType = "btrfs";
    options = [ "subvol=plex-config" "nofail" "discard" ];
  };

  fileSystems."/mnt/videos" = bind "/mnt/data" "videos";
  fileSystems."/mnt/pictures" = bind "/mnt/data" "pictures";
  fileSystems."/mnt/longhorn-backup" = bind "/mnt/data" "longhorn-backup";
  fileSystems."/mnt/backups" = bind "/mnt/data" "backups";

  fileSystems."/export/pictures" = bind "/mnt/data" "pictures";
  fileSystems."/export/backups" = bind "/mnt/data" "backups";
  fileSystems."/export/longhorn-backup" = bind "/mnt/data" "longhorn-backup";
  fileSystems."/export/videos" = bind "/mnt/data" "videos";


  services.rpcbind.enable = true;
  services.nfs.server.enable = true;
  services.nfs.server.statdPort = 4000;
  services.nfs.server.lockdPort = 4001;
  services.nfs.server.mountdPort = 4002;
  services.nfs.server.exports = ''
    /export/pictures *(rw,async,insecure)
    /export/backups *(rw,no_root_squash,async,insecure)
    /export/longhorn-backup *(rw,no_root_squash,async,insecure)
    /export/videos *(rw,async,insecure)
  '';

  services.samba.enable = true;
  services.samba-wsdd.enable = true;
  services.samba.openFirewall = true;
  services.samba.extraConfig = ''
    guest account = nobody
    map to guest = Bad User
  '';

  services.samba.shares =
    let
      simpleShare = path: {
        "path" = path;
        "read only" = false;
        "browseable" = "yes";
        "guest ok" = "yes";
        "admin users" = "addem jonas";
      };
    in
    {
      videos = simpleShare "/mnt/videos";
      pictures = simpleShare "/mnt/pictures";
      backups = simpleShare "/mnt/backups";
    };

  services.netatalk.enable = true;
  services.netatalk.settings =
    let
      simpleShare = path: {
        path = path;
        "time machine" = "no";
      };
    in
    {
      videos = simpleShare "/mnt/videos";
      pictures = simpleShare "/mnt/pictures";
      backups = simpleShare "/mnt/backups" // { "time machine" = "yes"; };
    };

  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.fileSystems = [ "/" "/mnt/data" "/mnt/solid-data" ];

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

}
