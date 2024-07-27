{
  config.hardware.deviceTree.overlays = [
    {
      name = "something-something-overlay";
      dtsText = ''
        /dts-v1/;
        /plugin/;
        / {
          compatible = "brcm,bcm2711";
          fragment@0 {
            target = <&something>;
            __overlay__ {
              status = "something";
            };
          };
        };
      '';
    }
  ];
}
