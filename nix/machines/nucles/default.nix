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

  system.autoUpgrade = {
    enable = true;
    flake = "/home/addem/homelab";
    dates = "Sat,Sun";
    flags = [];
    operation = "boot";
  };
  systemd.services."nixos-upgrade".serviceConfig.ExecStartPre = pkgs.writeShellScript "flake-pull" ''
    cd /home/addem/homelab
    ${pkgs.git}/bin/git restore .
    ${pkgs.sudo}/bin/sudo -u addem ${pkgs.git}/bin/git pull
  '';

  networking.domain = "localdomain";

  systemd.network.enable = true;
  systemd.network.networks.lan.name = "en*";
  systemd.network.networks.lan.DHCP = "yes";
  networking.dhcpcd.enable = false;
  systemd.network.wait-online.anyInterface = true;
  services.resolved.dnssec = "false"; # dnssec fails for localdomain and breaks stuff

  security.sudo.wheelNeedsPassword = false;
}
