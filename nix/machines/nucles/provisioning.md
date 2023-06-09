
Host config`./<new-node>/default.nix`:
```nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  networking.hostName = "new-node";

  services.kubeadm.init.enable = true;
  services.kubeadm.init.bootstrapTokenFile = "/var/secret/kubeadm-bootstrap-token"; 

  # for control plane
  services.kubeadm.controlPlane = true;
  services.kubeadm.init.certificateKeyFile = "/var/secret/kubeadm-cert-key";
}
```

Add host config in root `flake.nix`
```nix
      nixosConfigurations.<new-node> = machine "<new-node>" [ addem-basic ];

      nixosConfigurations.<some-pxe-host> = ... {
        ...
        modules = [
          ...

          "${self}/packages/pixie-api/module.nix"
          {
            services.pixiecore-host-configs.enable = true;
            services.pixiecore-host-configs.hosts = {
              "84:a9:3e:10:c4:66" = {
                nixosSystem = nixosConfigurations.nucle-installer;
                kernelParams = [ "hostname=<new-node>" ];
              };
            };
          }
        ];
      };
```


Check that everything went well
```sh
ssh new-node.localdomain
cd flakefiles
git pull

sudo ./users/mkshadow.sh addem # TODO: perhaps just drop the hash in a .nix file instead to skip this
sudo nixos-rebuild switch

# These will be failing
systemctl status kubeadm-join
systemctl status kubelet
```

Setup kubelet bootstap token, and rebuild
```sh
# TODO: this should/could be fetched via pixie-api instead? (cant pipelike thsi because of sudo)
ssh nucle1.localdomain -- kubeadm token create | ssh new-node.localdomain -- sudo tee /var/secret/kubeadm-bootstrap-token

#for controlplane (cant pipe like this because sudo...)
ssh nucle1.localdomain -- sudo kubeadm init phase upload-certs --upload-certs | grep -v upload-certs | ssh new-node.localdomain -- sudo tee /var/secret/kubeadm-cert-key

ssh new-node.localdomain
# Now these hopefully succeed / start
systemctl status kubeadm-join
systemctl status kubelet
````

Finally remove anyting under `services.kubeadm.init` from `./<new-node>/default.nix` and commit, push, pull and rebuild