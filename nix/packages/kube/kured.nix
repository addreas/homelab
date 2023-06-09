{ pkgs, ... }:
{
  config = {
    systemd.services.nixos-upgrade.onSuccess = [ "reboot-sentinel.service" ];

    systemd.services.reboot-sentinel = {
      description = "Create a kubereboot/kured style /var/run/reboot-required sentinel file if booted kernel differs from built kernel";

      serviceConfig.Type = "oneshot";

      script =
        let
          readlink = "${pkgs.coreutils}/bin/readlink";
        in
        ''
          booted="$(${readlink} /run/booted-system/{initrd,kernel,kernel-modules})"
          built="$(${readlink} /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})"

          if [ "''${booted}" = "''${built}" ]; then
            rm -f /var/run/reboot-required
          else
            touch /var/run/reboot-required
          fi
        '';
    };
  };
}
