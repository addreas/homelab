{
  description = "Just a bunch of stuff";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  inputs.flakefiles.url = "github:addreas/flakefiles";
  inputs.flakefiles.inputs.nixpkgs.follows = "nixpkgs";
  inputs.flakefiles.inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, flakefiles, ... }:
    let
      system = "x86_64-linux";

      machine = name: extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          "${self}/nix/machines/${name}"
          { environment.etc."nixos-source".source = self; }
          flakefiles.nixosModules.addem-basic
          flakefiles.nixosModules.base
          flakefiles.nixosModules.services
        ] ++ extraModules;
      };
    in
    {
      formatter.${system} = nixpkgs.legacyPkgs.${system}.nixpkgs-fmt;
      apps.${system} = flakefiles.apps.${system};

      # nix build .#nixosConfigurations.frr-test.config.system.build.vm
      # QEMU_KERNEL_PARAMS=console=ttyS0 ./result/bin/run-nixos-vm -nographic; reset
      nixosConfigurations.frr-test = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./nix/machines/frr-test/configuration.nix ];
      };

      nixosConfigurations.sergio = machine "sergio" [
        flakefiles.nixosModules.nix-builder

        # "${self}/nix/packages/pixie-api/module.nix"
        # {
        #   services.pixiecore-host-configs.enable = true;
        #   services.pixiecore-host-configs.hosts = let
        #     nucle-installer = name: {
        #       nixosSystem = self.nixosConfigurations.nucle-installer;
        #       kernelParams = [ "hostname=${name}" ];
        #     };
        #   in {
        #     # "1c:69:7a:a0:af:3e" = nucle-installer "nucle1";
        #     # "1c:69:7a:6f:c2:b8" = nucle-installer "nucle2";
        #     # "1c:69:7a:01:84:76" = nucle-installer "nucle3";
        #     # "84:a9:3e:10:c4:66" = nucle-installer "nucle4";
        #     # "38:22:e2:0d:85:f6" = nucle-installer "nucle3";
        #   };
        # }
      ];

      # nixosConfigurations.nucle-installer = machine "nucle-installer" [];

      # nixosConfigurations.nucle2 = machine "nucles/nucle2" [];
      # nixosConfigurations.nucle3 = machine "nucles/nucle3" [];
      # nixosConfigurations.nucle4 = machine "nucles/nucle4" [];
    };
}
