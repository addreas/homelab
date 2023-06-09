# TODO: pixie-api mTLS?
# TODO: serve this via pixie-api
# TODO: fetch bootstrap tokens from pixie-api

DEVICE=/dev/nvme0n1

MNT=/mnt

set -e
set -x

umount $MNT/var/lib/longhorn || true
umount $MNT/{boot,home,nix,var/log,var/lib} || true
umount $MNT || true

echo
echo "Nuking $DEVICE in 10 seconds"
echo "Yank power cord to abort"
echo

sleep 10

parted --script ${DEVICE} \
                mklabel gpt \
                mkpart esp fat32 1MiB 512MiB \
                mkpart os btrfs 512MiB 20GiB \
                mkpart data ext4 50% 100% \
                set 1 esp on \
                set 1 boot on

mkfs.fat -F 32 ${DEVICE}p1
mkfs.btrfs ${DEVICE}p2 -f
mkfs.ext4 ${DEVICE}p3

P2=${DEVICE}p2
mount -t btrfs "$P2" $MNT/
btrfs subvolume create "$MNT/@"
btrfs subvolume create "$MNT/@home"
btrfs subvolume create "$MNT/@nix"
btrfs subvolume create "$MNT/@varlog"
btrfs subvolume create "$MNT/@varlib"
umount "$MNT"

mount -t btrfs -o noatime,compress=zstd,subvol=@ "$P2" "$MNT"

mkdir -p $MNT/{boot,home,nix,var/log,var/lib}

mount -t vfat  -o noatime,defaults ${DEVICE}p1 "$MNT/boot"

mount -t btrfs -o noatime,compress=zstd,subvol=@home "$P2" "$MNT/home"
mount -t btrfs -o noatime,compress=zstd,subvol=@nix "$P2" "$MNT/nix"
mount -t btrfs -o noatime,compress=zstd,subvol=@varlib "$P2" "$MNT/var/lib"
mount -t btrfs -o noatime,compress=zstd,subvol=@varlog "$P2" "$MNT/var/log"

mkdir $MNT/var/lib/longhorn

mount -t ext4  -o noatime,defaults ${DEVICE}p3 "$MNT/var/lib/longhorn"

mkdir -p "$MNT/home/addem/.ssh"
ssh-keygen \
  -t ed25519 \
  -C "addem@$(hostname)" \
  -f "$MNT/home/addem/.ssh/id_ed25519" \
  -N ""

chmod 600 "$MNT/home/addem/.ssh/id_ed25519.pub"

curl "$(cmdline pixie-api)/v1/ssh-key/addem@$(hostname)" \
  --silent \
  --request POST \
  --upload-file - < "$MNT/home/addem/.ssh/id_ed25519.pub"

export GIT_SSH_COMMAND="ssh -i $MNT/home/addem/.ssh/id_ed25519"

git clone git@github.com:addreas/flakefiles.git $MNT/home/addem/flakefiles

nixos-generate-config --root $MNT

cd $MNT/home/addem/flakefiles
cp "$MNT/etc/nixos/hardware-configuration.nix" \
  "./machines/nucles/$(hostname)"
git add "./machines/nucles/$(hostname)"

ln -s -r \
  "$MNT/home/addem/flakefiles/flake.nix" \
  "$MNT/etc/nixos"

nixos-install \
  --root $MNT \
  --no-root-password \
  --option extra-experimental-features auto-allocate-uids \
  --option extra-experimental-features cgroups \
  --flake "$MNT/home/addem/flakefiles#$(hostname)"

git add .
git config user.email "$(hostname)@addem.se"
git config user.name "$(hostname)"
git commit -am "add newly generated hardware-configuration.nix for $(hostname)"
git push

chown --recursive 1000:users $MNT/home/addem/

curl "$(cmdline pixie-api)/v1/install-finished/$(cmdline mac)" \
  --silent \
  --request POST

reboot
