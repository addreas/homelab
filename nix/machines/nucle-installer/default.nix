{ config, pkgs, lib, modulesPath, ... }:
let
  cmdline = pkgs.writeScriptBin "cmdline" (
    builtins.replaceStrings
      [ "/usr/bin/env python3" ]
      [ "${pkgs.python3}/bin/python" ]
      (builtins.readFile ./cmdline.py)
  );
  nuke = pkgs.writeShellApplication {
    name = "nuke-nvme0n1-and-install";
    runtimeInputs = with pkgs; [
      parted
      curl
      git
      openssh
      btrfs-progs
      dosfstools
      e2fsprogs
      nettools
      util-linux
      nix
      nixos-install-tools

      cmdline
    ];
    text = builtins.readFile ./nuke.sh;
  };
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/installer/netboot/netboot-minimal.nix")

    ../common/base.nix
  ];

  system.stateVersion = "22.11";

  networking.hostName = ""; # these have to be set via kernel cmdline

  system.activationScripts.cmdline-setup = ''
    HOSTNAME=$(${cmdline}/bin/cmdline hostname)
    if [[ "$HOSTNAME" != "" ]]; then
      hostname $HOSTNAME
      echo $HOSTNAME > /etc/hostname
    fi
  '';

  services.getty.autologinUser = lib.mkForce "root";
  services.kmscon.autologinUser = lib.mkForce "root";

  programs.ssh.knownHostsFiles = [
    (pkgs.writeText "github.keys" ''
      github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
      github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
      github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
    '')
  ];

  environment.systemPackages = [
    nuke
    cmdline
  ];

  systemd.services.nuke-and-install = {
    description = "Nuke /dev/nvme0n1 and install nucle";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${nuke}/bin/nuke-nvme0n1-and-install";
      StandardOutput = "journal+console";
    };
  };
}
