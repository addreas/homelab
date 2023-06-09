{
  description = "Just a bunch of stuff";

  inputs.nixpkgs.url = "nixpkgs/nixos-23.05";

  inputs.flakefiles.url = "github:addreas/flakefiles";

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
      apps.${system}.diff-current-system = flakefiles.apps.${system}.diff-current-system;

      nixosConfigurations.sergio = machine "sergio" [
        flakefiles.nixosModules.nix-builder

        # "${self}/nix/packages/pixie-api/module.nix"
        # {
        #   services.pixiecore-host-configs.enable = true;
        #   services.pixiecore-host-configs.hosts = let
        #     nucle-installer = name: {
        #       nixosSystem = nixosConfigurations.nucle-installer;
        #       kernelParams = [ "hostname=${name}" ];
        #     };
        #   in {
        #     # "1c:69:7a:a0:af:3e" = nucle-installer "nucle1";
        #     # "1c:69:7a:6f:c2:b8" = nucle-installer "nucle2";
        #     # "1c:69:7a:01:84:76" = nucle-installer "nucle3";
        #     # "84:a9:3e:10:c4:66" = nucle-installer "nucle4";
        #   };
        # }
      ];

      # nixosConfigurations.nucle1 = machine "nucles/nucle1" [];
      # nixosConfigurations.nucle2 = machine "nucles/nucle2" [];
      nixosConfigurations.nucle3 = machine "nucles/nucle3" [];
      nixosConfigurations.nucle4 = machine "nucles/nucle4" [];
    };
}
