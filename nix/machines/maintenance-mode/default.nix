{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/installer/netboot/netboot-minimal.nix")
  ];

  system.stateVersion = "22.11";
  networking.hostName = "nixos";
  services.getty.autologinUser = lib.mkForce "root";

  environment.systemPackages = with pkgs; [
    fwupd
    efibootmgr
    vim
    helix
    wget
    curl
    jq
    yq
    dig
    git
    inetutils
  ];

}
