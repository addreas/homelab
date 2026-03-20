{ pkgs, lib, host, cmdline ? "", ... }:
let
  systemBuild = host.config.system.build;
in
 pkgs.writeShellApplication {
  name = "nixiecore";
  runtimeInputs = [ pkgs.pixiecore ];
  text = ''
    pixiecore boot \
      ${systemBuild.kernel}/bzImage \
      ${systemBuild.netbootRamdisk}/initrd \
      --cmdline "init=${systemBuild.toplevel}/init ${cmdline}" \
      --debug \
      --dhcp-no-bind \
      --port 8324
  '';
}
