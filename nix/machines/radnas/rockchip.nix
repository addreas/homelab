{ pkgs, rkbinTools, pkgsCrossArm, pkgs86, lib, ... }: let
#  rkbin = pkgs.fetchFromGitHub {
#     owner = "rockchip-linux";
#     repo = "rkbin";
#     rev = "b4558da0860ca48bf1a571dd33ccba580b9abe23";
#     sha256 = "KUZQaQ+IZ0OynawlYGW99QGAOmOrGt2CZidI3NTxFw8=";
#   };
in {
  rockchip.uBoot = pkgsCrossArm.buildUBoot {
    # src = pkgs.fetchFromGitHub {
    #     owner = "Kwiboo";
    #     repo = "u-boot-rockchip";
    #     rev = "rk3xxx-2024.10";
    #     sha256 = "IlaDdjKq/Pq2orzcU959h93WXRZfvKBGDO/MFw9mZMg=";
    #   };
    # version = "v2024.10-rockchip";
    src = pkgs.fetchFromGitHub {
        owner = "u-boot";
        repo = "u-boot";
        rev = "v2024.07";
        sha256 = "IlaDdjKq/Pq2orzcU959h93WXRZfvKBGDO/MFw9mZMg=";
      };
    version = "v2024.07"; # git describe --long

    # https://github.com/armbian/build/blob/f5a9fc2d92a412a5f38ac56bf4c7b17f2fc2a72d/config/boards/rock-4se.csc#L6
    # defconfig = "rock-pi-4-rk3399_defconfig";
    defconfig = "rock-4se-rk3399_defconfig";
    extraMeta.platforms = [ "aarch64-linux" ];
    BL31 = "${pkgs.armTrustedFirmwareRK3399}/bl31.elf";
    # https://docs.u-boot.org/en/latest/board/rockchip/rockchip.html
    # https://github.com/Kwiboo/u-boot-rockchip/blob/73f8efaab35d9302c2b43b4546030da85c6d6a81/doc/board/rockchip/rockchip.rst
    # BL31 = "${rkbin}/bin/rk33/rk3399_bl31_v1.36.elf";
    ROCKCHIP_TPL = "${rkbin}/bin/rk33/rk3399_ddr_800MHz_v1.30.bin";

    # https://github.com/nabam/nixos-rockchip/blob/main/pkgs/uboot-rockchip.nix
    filesToInstall = [ "u-boot-rockchip.bin" ];
    # extraPatches = [ ./ramdisk_addr_r.patch ];
    extraConfig = ''
      CONFIG_LOG=y
      CONFIG_LOG_MAX_LEVEL=7
      CONFIG_TPL_LOG=y
      CONFIG_TPL_LOG_MAX_LEVEL=7
      CONFIG_SPL_LOG=y
      CONFIG_SPL_LOG_MAX_LEVEL=7
    '';

    # postBuild = ''
    #   # ${rkbinTools}/loaderimage --pack --uboot ./u-boot-dtb.bin uboot.img 0x200000 --size 1024 1
    #   tools/mkimage -n rk3399 -T rksd -d ${rkbin}/bin/rk33/rk3399_ddr_800MHz_v1.30.bin idbloader.img
    #   cat ${rkbin}/bin/rk33/rk3399_miniloader_v1.30.bin >> idbloader.img
    #   sed 's|PATH=bin|PATH=${rkbin}/bin|' ${rkbin}/RKTRUST/RK3399TRUST.ini > trust.ini
    #   ${rkbinTools}/trust_merger --size 1024 1 trust.ini

    #   truncate -s 32768 u-boot-rockchip.bin
    #   dd if=idbloader.img of=u-boot-rockchip.bin bs=512 seek=64
    #   dd if=u-boot.img of=u-boot-rockchip.bin bs=512 seek=16384
    #   dd if=trust.img of=u-boot-rockchip.bin bs=512 seek=24576
    # '';

    # https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
    # http://cholla.mmto.org/rk3399/really_bare.html
    # https://stikonas.eu/wordpress/tag/rk3399/
    # https://opensource.rock-chips.com/wiki_U-Boot
    # https://opensource.rock-chips.com/wiki_Boot_option
    # https://opensource.rock-chips.com/wiki_Rockusb#Maskrom_mode
    # https://opensource.rock-chips.com/wiki_Partitions
    # https://docs.u-boot.org/en/latest/board/rockchip/rockchip.html#flashing

  };
  boot.loader.generic-extlinux-compatible.enable = true;
  # boot.kernelPackages = with pkgsCrossArm.linuxKernel; packagesFor
  #   (kernels.linux_6_10.override {
  #     structuredExtraConfig = with lib.kernel; {
  #       ARCH_ROCKCHIP = yes;
  #       CHARGER_RK817 = yes;
  #       COMMON_CLK_RK808 = yes;
  #       COMMON_CLK_ROCKCHIP = yes;
  #       DRM_ROCKCHIP = yes;
  #       GPIO_ROCKCHIP = yes;
  #       MFD_RK808 = yes;
  #       MMC_DW = yes;
  #       MMC_DW_ROCKCHIP = yes;
  #       MMC_SDHCI_OF_DWCMSHC = yes;
  #       MOTORCOMM_PHY = yes;
  #       PCIE_ROCKCHIP_DW_HOST = yes;
  #       PHY_ROCKCHIP_INNO_CSIDPHY = yes;
  #       PHY_ROCKCHIP_INNO_DSIDPHY = yes;
  #       PHY_ROCKCHIP_INNO_USB2 = yes;
  #       PHY_ROCKCHIP_NANENG_COMBO_PHY = yes;
  #       PINCTRL_ROCKCHIP = yes;
  #       PWM_ROCKCHIP = yes;
  #       REGULATOR_RK808 = yes;
  #       ROCKCHIP_DW_HDMI = yes;
  #       ROCKCHIP_IODOMAIN = yes;
  #       ROCKCHIP_IOMMU = yes;
  #       ROCKCHIP_MBOX = yes;
  #       ROCKCHIP_PHY = yes;
  #       ROCKCHIP_PM_DOMAINS = yes;
  #       ROCKCHIP_SARADC = yes;
  #       ROCKCHIP_THERMAL = yes;
  #       ROCKCHIP_VOP2 = yes;
  #       RTC_DRV_RK808 = yes;
  #       SND_SOC_RK817 = yes;
  #       SND_SOC_ROCKCHIP = yes;
  #       SND_SOC_ROCKCHIP_I2S_TDM = yes;
  #       SPI_ROCKCHIP = yes;
  #       STMMAC_ETH = yes;
  #       VIDEO_HANTRO_ROCKCHIP = yes;
  #     };
  #   });
}
