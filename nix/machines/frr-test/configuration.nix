#nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-23.11 -I nixos-config=./configuration.nix
{ config, pkgs, lib, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     cowsay
  #     lolcat
  #   ];
  #   initialPassword = "test";
  # };

  system.stateVersion = "23.11";
  
  services.getty.autologinUser = lib.mkForce "root";

  services.frr.bgp = {
    enable = true;
    config = ''
      router bgp 64512
       neighbor 192.168.0.64 remote-as 64512
       neighbor 192.168.0.106 remote-as 64512
       neighbor 192.168.0.192 remote-as 64512
      '';
  };
}
