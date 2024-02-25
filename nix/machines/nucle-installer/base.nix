{ config, pkgs, lib, ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"

      # https://github.com/NixOS/nix/pull/3600
      "auto-allocate-uids"
      "cgroups"
    ];
    system-features = [ "kvm" "big-parallel" "uid-range" ];
    auto-allocate-uids = true;
    use-cgroups = true;

    substituters = [
      "http://nucles.localdomain:9723"
      "https://nix-community.cachix.org"
    ];

    trusted-users = [ "root" "@wheel" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "sergio-0:iLOUuTIPPeJARAemTdAhD4y0Yi+/luB52jiQhMYBwVE="
    ];
  };

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    zsh
    vim
    helix
    curl
    git
    parted
  ];
}

