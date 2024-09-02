{ pkgs, pkgsCrossArm, lib, ... }: {
  rockchip.uBoot = pkgsCrossArm.buildUBoot {
    # https://github.com/armbian/build/blob/f5a9fc2d92a412a5f38ac56bf4c7b17f2fc2a72d/config/boards/rock-4se.csc#L6
    # defconfig = "rock-4se-rk3399_defconfig";
    defconfig = "rock-pi-4-rk3399_defconfig";
    extraMeta.platforms = [ "aarch64-linux" ];
    BL31 = "${pkgs.armTrustedFirmwareRK3399}/bl31.elf";
    # https://github.com/nabam/nixos-rockchip/blob/main/pkgs/uboot-rockchip.nix
    filesToInstall = [ "u-boot-rockchip.bin" ];
  };
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelPackages = with pkgsCrossArm.linuxKernel; packagesFor
    (kernels.linux_6_9.override {
      structuredExtraConfig = with lib.kernel; {
        ARCH_ROCKCHIP = yes;
        CHARGER_RK817 = yes;
        COMMON_CLK_RK808 = yes;
        COMMON_CLK_ROCKCHIP = yes;
        DRM_ROCKCHIP = yes;
        GPIO_ROCKCHIP = yes;
        MFD_RK808 = yes;
        MMC_DW = yes;
        MMC_DW_ROCKCHIP = yes;
        MMC_SDHCI_OF_DWCMSHC = yes;
        MOTORCOMM_PHY = yes;
        PCIE_ROCKCHIP_DW_HOST = yes;
        PHY_ROCKCHIP_INNO_CSIDPHY = yes;
        PHY_ROCKCHIP_INNO_DSIDPHY = yes;
        PHY_ROCKCHIP_INNO_USB2 = yes;
        PHY_ROCKCHIP_NANENG_COMBO_PHY = yes;
        PINCTRL_ROCKCHIP = yes;
        PWM_ROCKCHIP = yes;
        REGULATOR_RK808 = yes;
        ROCKCHIP_DW_HDMI = yes;
        ROCKCHIP_IODOMAIN = yes;
        ROCKCHIP_IOMMU = yes;
        ROCKCHIP_MBOX = yes;
        ROCKCHIP_PHY = yes;
        ROCKCHIP_PM_DOMAINS = yes;
        ROCKCHIP_SARADC = yes;
        ROCKCHIP_THERMAL = yes;
        ROCKCHIP_VOP2 = yes;
        RTC_DRV_RK808 = yes;
        SND_SOC_RK817 = yes;
        SND_SOC_ROCKCHIP = yes;
        SND_SOC_ROCKCHIP_I2S_TDM = yes;
        SPI_ROCKCHIP = yes;
        STMMAC_ETH = yes;
        VIDEO_HANTRO_ROCKCHIP = yes;
      };
    });
}
