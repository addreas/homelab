{ modulesPath, ... }: {

  imports = [
    "${modulesPath}/profiles/headless.nix"
    "${modulesPath}/profiles/minimal.nix"
  ];

  # only add strictly necessary modules
  # boot.initrd.includeDefaultModules = false;
  # boot.initrd.kernelModules = [ "ext4" ... ];
  disabledModules =
    [
      "${modulesPath}/profiles/all-hardware.nix"
      "${modulesPath}/profiles/base.nix"
    ];

  # disable useless software
  environment.defaultPackages = [ ];
  xdg.icons.enable = false;
  xdg.mime.enable = false;
  xdg.sounds.enable = false;
}
