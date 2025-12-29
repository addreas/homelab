{ pkgs, ... }: {
  imports = [
    ./kube.nix

    # ../common/base.nix
    # ../common/services.nix
  ];
  swapDevices = [ ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = false;

  system.stateVersion = "22.11";

  # system.autoUpgrade = {
  #   enable = true;
  #   flake = "/home/addem/homelab";
  #   dates = "Sat,Sun 05:40";
  #   flags = [ ];
  #   operation = "boot";
  # };
  # systemd.services."nixos-upgrade".serviceConfig.ExecStartPre = pkgs.writeShellScript "flake-pull" ''
  #   cd /home/addem/homelab
  #   ${pkgs.git}/bin/git restore .
  #   ${pkgs.sudo}/bin/sudo -u addem ${pkgs.git}/bin/git pull
  # '';

  networking.domain = "localdomain";
  networking.useNetworkd = true;

  systemd.network.enable = true;
  systemd.network.wait-online.extraArgs = [ "--interface=eno1" ];
  services.resolved.dnssec = "false"; # dnssec fails for localdomain and breaks stuff

  security.sudo.wheelNeedsPassword = false;

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 14d";
}
