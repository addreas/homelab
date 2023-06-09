{ pkgs, ... }: {

  config = {

    virtualisation.cri-o = {
      enable = true;
      storageDriver = "btrfs";
      settings.crio.network.plugin_dirs = [ "/opt/cni/bin" "${pkgs.cni-plugins}/bin" ];
      settings.crio.runtime.default_env = [ "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/run/wrappers/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin" ];
    };

    system.activationScripts.var-lib-crio = "mkdir -p /var/lib/crio";

  };
}
