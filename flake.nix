{
  description = "Just a bunch of stuff";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.nixpkgs-24.url = "nixpkgs/nixos-24.11";

  inputs.flakefiles.url = "github:addreas/flakefiles";

  outputs = { self, nixpkgs, nixpkgs-24, flakefiles, ... }:
    let
      x86 = "x86_64-linux";

      machine = system: name: extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs.nixpkgs = nixpkgs;
        modules = [
          "${self}/nix/machines/${name}"
          {
            environment.etc."nixos-source".source = self;
          }
          flakefiles.nixosModules.addem-basic
          flakefiles.nixosModules.base
          flakefiles.nixosModules.services
        ] ++ extraModules;
      };
    in
    {
      formatter.${x86} = nixpkgs.legacyPackages.${x86}.nixpkgs-fmt;
      apps.${x86} = flakefiles.apps.${x86};

      nixosConfigurations.sergio = machine x86 "sergio" [
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
      nixosConfigurations.nucle3 = machine x86 "nucles/nucle3" [ ];
      nixosConfigurations.nucle4 = machine x86 "nucles/nucle4" [ ];
    };
}
