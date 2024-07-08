{ config, pkgs, lib, ... }:
{
  imports = [
    ./sd-image.nix
  ];

  system.stateVersion = "24.05";

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "arm-trusted-firmware-rk3399"
  ];

  sdImage.populateRootCommands = ''
    mkdir -p ./files/boot
    ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./files/boot
  '';
}
