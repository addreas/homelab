#!/usr/bin/env bash
# nix-shell -p git
# sudo ./disaster.sh /dev/nvme1n1p{2,1}

DISK=$1
BOOT=$2

mount $DISK /mnt
mount $BOOT /mnt/@/boot
for sub in "nix" "home" "var/lib" "var/log"; do
  mount $DISK /mnt/@/$sub -o subvol=@${sub/\/}
done

nixos-install --root /mnt/@ --no-root-password --flake .\#sergio
