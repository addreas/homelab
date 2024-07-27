{ modulesPath, config, lib, pkgs, ... }:
with lib;
let
  uboot = pkgs.buildUBoot {
    # https://github.com/armbian/build/blob/f5a9fc2d92a412a5f38ac56bf4c7b17f2fc2a72d/config/boards/rock-4se.csc#L6
    defconfig = "rock-4se-rk3399_defconfig";
    # defconfig = "rock-pi-4-rk3399_defconfig"; 
    extraMeta.platforms = [ "aarch64-linux" ];
    BL31 = "${pkgs.armTrustedFirmwareRK3399}/bl31.elf";
    filesToInstall = [ "idbloader.img" "u-boot.itb" ".config" ];
  };

  rootfsImage = pkgs.callPackage "${modulesPath}/../lib/make-ext4-fs.nix" ({
    inherit (config.sdImage) storePaths;
    compressImage = true;
    populateImageCommands = config.sdImage.populateRootCommands;
    volumeLabel = "NIXOS_SD";
  } // optionalAttrs (config.sdImage.rootPartitionUUID != null) {
    uuid = config.sdImage.rootPartitionUUID;
  });
in
{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  # options.sdImage = {
  #   imageName = mkOption {
  #     default =
  #       "${config.sdImage.imageBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.img";
  #     description = ''
  #       Name of the generated image file.
  #     '';
  #   };

  #   imageBaseName = mkOption {
  #     default = "nixos-sd-image";
  #     description = ''
  #       Prefix of the name of the generated image file.
  #     '';
  #   };

  #   storePaths = mkOption {
  #     type = with types; listOf package;
  #     example = literalExpression "[ pkgs.stdenv ]";
  #     description = ''
  #       Derivations to be included in the Nix store in the generated SD image.
  #     '';
  #   };

  #   rootPartitionUUID = mkOption {
  #     type = types.nullOr types.str;
  #     default = null;
  #     example = "14e19a7b-0ae0-484d-9d54-43bd6fdc20c7";
  #     description = ''
  #       UUID for the filesystem on the main NixOS partition on the SD card.
  #     '';
  #   };

  #   populateRootCommands = mkOption {
  #     example = literalExpression
  #       "''\${config.boot.loader.generic-extlinux-compatible.populateCmd} -c \${config.system.build.toplevel} -d ./files/boot''";
  #     description = ''
  #       Shell commands to populate the ./files directory.
  #       All files in that directory are copied to the
  #       root (/) partition on the SD image. Use this to
  #       populate the ./files/boot (/boot) directory.
  #     '';
  #   };

  #   postBuildCommands = mkOption {
  #     example = literalExpression
  #       "'' dd if=\${pkgs.myBootLoader}/SPL of=$img bs=1024 seek=1 conv=notrunc ''";
  #     default = "";
  #     description = ''
  #       Shell commands to run after the image is built.
  #       Can be used for boards requiring to dd u-boot SPL before actual partitions.
  #     '';
  #   };

  #   compressImage = mkOption {
  #     type = types.bool;
  #     default = true;
  #     description = ''
  #       Whether the SD image should be compressed using
  #       <command>zstd</command>.
  #     '';
  #   };

  #   expandOnBoot = mkOption {
  #     type = types.bool;
  #     default = true;
  #     description = ''
  #       Whether to configure the sd image to expand it's partition on boot.
  #     '';
  #   };
  # };


  config = {
    boot.loader.grub.enable = false;
    boot.loader.generic-extlinux-compatible.enable = true;

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "arm-trusted-firmware-rk3399" ];

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
      };
    };

    sdImage.compressImage = false;

    # sdImage.storePaths = [ config.system.build.toplevel ];
    # sdImage.populateRootCommands = ''
    #   mkdir -p ./files/boot
    #   ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./files/boot
    # '';

    system.build.sdImage = lib.mkForce (pkgs.callPackage
      ({ stdenv, dosfstools, e2fsprogs, mtools, libfaketime, util-linux, zstd }:
        stdenv.mkDerivation {
          name = config.sdImage.imageName;

          nativeBuildInputs =
            [ dosfstools e2fsprogs mtools libfaketime util-linux zstd ];

          inherit (config.sdImage) compressImage;

          diskUUID = "992DF2C2-0170-4F66-9492-FBF320673EEF";
          load1UUID = "95D89D52-CA00-42D6-883F-50F5720EF37E";
          load2UUID = "78BE2786-ACB9-4885-BB6C-77DDDEF5AAC9";
          rootUUID = "B921B045-1DF0-41C3-AF44-4C6F280D3FAE";

          buildCommand = ''
            mkdir -p $out/nix-support $out/sd-image
            export img=$out/sd-image/${config.sdImage.imageName}

            echo "${pkgs.stdenv.buildPlatform.system}" > $out/nix-support/system
            if test -n "$compressImage"; then
              echo "file sd-image $img.zst" >> $out/nix-support/hydra-build-products
            else
              echo "file sd-image $img" >> $out/nix-support/hydra-build-products
            fi

            echo "Decompressing rootfs image"
            zstd -d --no-progress "${rootfsImage}" -o ./root-fs.img

            # Create the image file sized to fit idbloader/uboot and /, plus slack for the gap.
            rootSizeBlocks=$(du -B 512 --apparent-size ./root-fs.img | awk '{ print $1 }')
            imageSize=$((rootSizeBlocks * 512 + 32768))
            truncate -s $imageSize $img

            sfdisk --no-reread --no-tell-kernel $img <<EOF
                label: gpt
                label-id: $diskUUID
                first-lba: 64
                start=64,    size=8000, type=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7, uuid=$load1UUID, name=loader1
                start=16384, size=8192, type=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7, uuid=$load2UUID, name=loader2
                start=32768,            type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, uuid=$rootUUID, name=rootfs
            EOF

            # label: gpt
            # label-id: D6A63D4E-3609-4FE1-8BA9-69D6C9CA2D5E
            # device: rockpi-4b-ubuntu-focal-server-arm64-20221109-1331-gpt.img
            # unit: sectors
            # first-lba: 34
            # last-lba: 3906216
            # sector-size: 512

            # rockpi-4b-ubuntu-focal-server-arm64-20221109-1331-gpt.img1 : start=          64, size=        8000, type=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7, uuid=D22797A4-8273-4385-A2FF-C634BB0CC3AA, name="loader1"
            # rockpi-4b-ubuntu-focal-server-arm64-20221109-1331-gpt.img2 : start=       16384, size=        8192, type=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7, uuid=010DEC40-9612-4A5C-B48B-4924209815AC, name="loader2"
            # rockpi-4b-ubuntu-focal-server-arm64-20221109-1331-gpt.img3 : start=       24576, size=        8192, type=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7, uuid=D9A9E324-DF22-42E8-9D12-84C38D83163B, name="trust"
            # rockpi-4b-ubuntu-focal-server-arm64-20221109-1331-gpt.img4 : start=       32768, size=     1048576, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, uuid=54307E29-C12C-4CF5-B4D9-66D3621F0869, name="boot"
            # rockpi-4b-ubuntu-focal-server-arm64-20221109-1331-gpt.img5 : start=     1081344, size=     2824873, type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, uuid=D2D878BA-6A80-4F91-9E09-CFAE21075394, name="rootfs"


            # label: gpt
            # label-id: 0E61F569-3750-49D4-AF1C-635C1972081D
            # device: /dev/sda
            # unit: sectors
            # first-lba: 34
            # last-lba: 11001384
            # sector-size: 512

            # rock-4se_debial_bullseye_kde_b33.img1 : start=       32768, size=       32768, type=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7, uuid=78C815BB-53DA-4D71-B0B3-8FA4053624E3, name="config"
            # rock-4se_debial_bullseye_kde_b33.img2 : start=       65536, size=    10935849, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, uuid=2C06DCD8-E82C-46BF-AB45-E92E348B062E, name="rootfs"

            # label: gpt
            # label-id: D9D9C4F0-62B5-48B3-A55D-1C60F2433AA2
            # device: rock-4se_debian_bullseye_cli_b38.img
            # unit: sectors
            # first-lba: 34
            # last-lba: 4413616
            # sector-size: 512

            # rock-4se_debian_bullseye_cli_b38.img1 : start=       32768, size=       32768, type=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7, uuid=97B7EAB3-51B5-4381-A5AD-6B9B4EA7D669, name="config"
            # rock-4se_debian_bullseye_cli_b38.img2 : start=       65536, size=      614400, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, uuid=1FF93440-D601-4C00-86AE-CC790138A4B3, name="boot"
            # rock-4se_debian_bullseye_cli_b38.img3 : start=      679936, size=     3733681, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, uuid=64CD2C28-735D-4066-8346-D740592F8308, name="rootfs"

            

            # Copy the rootfs into the SD image
            eval $(partx $img -o START,SECTORS --nr 3 --pairs)
            dd conv=notrunc if=./root-fs.img of=$img seek=$START count=$SECTORS

            # Copy u-boot into the SD image
            eval $(partx $img -o START,SECTORS --nr 2 --pairs)
            dd conv=notrunc if=${uboot}/u-boot.itb of=$img seek=$START count=$SECTORS

            # Copy bootloader into the SD image
            eval $(partx $img -o START,SECTORS --nr 1 --pairs)
            dd conv=notrunc if=${uboot}/idbloader.img of=$img seek=$START count=$SECTORS
            

            ${config.sdImage.postBuildCommands}

            if test -n "$compressImage"; then
                zstd -T$NIX_BUILD_CORES --rm $img
            fi
          '';
        })
      { });

    # boot.postBootCommands = lib.mkIf config.sdImage.expandOnBoot ''
    #   # On the first boot do some maintenance tasks
    #   if [ -f /nix-path-registration ]; then
    #     set -euo pipefail
    #     set -x
    #     # Figure out device names for the boot device and root filesystem.
    #     rootPart=$(${pkgs.util-linux}/bin/findmnt -n -o SOURCE /)
    #     bootDevice=$(lsblk -npo PKNAME $rootPart)
    #     partNum=$(lsblk -npo MAJ:MIN $rootPart | ${pkgs.gawk}/bin/awk -F: '{print $2}')

    #     # Resize the root partition and the filesystem to fit the disk
    #     echo ",+," | sfdisk -N$partNum --no-reread $bootDevice
    #     ${pkgs.parted}/bin/partprobe
    #     ${pkgs.e2fsprogs}/bin/resize2fs $rootPart

    #     # Register the contents of the initial Nix store
    #     ${config.nix.package.out}/bin/nix-store --load-db < /nix-path-registration

    #     # nixos-rebuild also requires a "system" profile and an /etc/NIXOS tag.
    #     touch /etc/NIXOS
    #     ${config.nix.package.out}/bin/nix-env -p /nix/var/nix/profiles/system --set /run/current-system

    #     # Prevents this from running on later boots.
    #     rm -f /nix-path-registration
    #   fi
    # '';
  };

}
