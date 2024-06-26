{ config, lib, pkgs, modulesPath, ... }:

let
  btrfsDataHDD = options: {
    device = "/dev/disk/by-uuid/d5f05d68-2761-4262-af48-af7b221daea5";
    fsType = "btrfs";
    options = options ++ [ "nofail" ];
  };
  btrfsDataSSD = options: {
    device = "/dev/disk/by-uuid/660b83df-c44d-4265-b293-272127aabf22";
    fsType = "btrfs";
    options = options ++ [ "nofail" ];
  };
  btrfsDataSSD2 = options: {
    device = "/dev/disk/by-uuid/b6df7c6f-d5fd-4f14-b02c-d57727db5a23";
    fsType = "btrfs";
    options = options ++ [ "nofail" ];
  };
  bind = source: subpath: {
    depends = [ source ];
    device = "${source}/${subpath}";
    fsType = "none";
    options = [ "bind" "nofail" ];
  };
in
{
  fileSystems."/mnt/data" = btrfsDataHDD [];
  fileSystems."/mnt/solid-data" = btrfsDataSSD2 [];
  fileSystems."/mnt/plex-config" = btrfsDataSSD [ "subvol=plex-config" ];

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
  services.btrfs.autoScrub.fileSystems = [ "/" "/mnt/data" ];


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
