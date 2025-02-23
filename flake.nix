{
  description = "Just a bunch of stuff";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  # inputs.nixpkgs-git.url = "github:NixOS/nixpkgs";

  inputs.flakefiles.url = "github:addreas/flakefiles";
  # inputs.flakefiles.inputs.nixpkgs.follows = "nixpkgs";
  # inputs.flakefiles.inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix";
  inputs.rockchip.url = "github:nabam/nixos-rockchip";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nabam-nixos-rockchip.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nabam-nixos-rockchip.cachix.org-1:BQDltcnV8GS/G86tdvjLwLFz1WeFqSk7O9yl+DR0AVM"
    ];
  };

  outputs = { self, nixpkgs, flakefiles, raspberry-pi-nix, rockchip, ... }:
    let
      x86 = "x86_64-linux";
      arm64 = "aarch64-linux";

      pkgsCrossArm = import nixpkgs {
        localSystem = x86;
        crossSystem = arm64;
      };

      machine = system: name: extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgsCrossArm nixpkgs; };
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

      # nix build .#nixosConfigurations.frr-test.config.system.build.vm
      # QEMU_KERNEL_PARAMS=console=ttyS0 ./result/bin/run-nixos-vm -nographic; reset
      # nixosConfigurations.frr-test = nixpkgs.lib.nixosSystem {
      #   inherit system;
      #   modules = [ ./nix/machines/frr-test/configuration.nix ];
      # };

      # packages.${x86}.rkbinTools = let
      #   pkgs = import nixpkgs { system = x86; };
      # in
      # pkgs.stdenvNoCC.mkDerivation {
      #   name = "rkbin-tools";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "rockchip-linux";
      #     repo = "rkbin";
      #     rev = "b4558da0860ca48bf1a571dd33ccba580b9abe23";
      #     sha256 = "KUZQaQ+IZ0OynawlYGW99QGAOmOrGt2CZidI3NTxFw8=";
      #   };

      #   nativeBuildInputs = with pkgs; [
      #     autoPatchelfHook
      #     gcc-unwrapped
      #     libusb
      #   ];

      #   # buildInputs = [ python3 ];

      #   installPhase = ''
      #     mkdir $out
      #     cp -r tools/* $out
      #   '';
      # };

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


      # https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_5
      # nix build .#nixosConfigurations.pinas.config.system.build.sdImage
      # zstdcat result/sd-image/nixos-sd-image-*-aarch64-linux.img.zst | sudo dd of=/dev/mmcblk0 bs=100M status=progress oflag=sync
      nixosConfigurations.pinas = machine arm64 "pinas" [
        raspberry-pi-nix.nixosModules.raspberry-pi
        raspberry-pi-nix.nixosModules.sd-image
        ./nix/packages/nas/module.nix
      ];

      # https://github.com/ryan4yin/nixos-rk3588?tab=readme-ov-file#references
      # nix build .#nixosConfigurations.radnas.config.system.build.sdImage
      # sudo dd if=$(echo result/sd-image/nixos-sd-image-*.img) of=/dev/sda bs=10M status=progress conv=fsync oflag=sync

      nixosConfigurations.radnas = nixpkgs.lib.nixosSystem {
        system = arm64;
        modules = [
          rockchip.nixosModules.sdImageRockchip
          "${self}/nix/machines/radnas"
        ];
        specialArgs = {
          inherit pkgsCrossArm;
          # rkbinTools = self.packages.${x86}.rkbinTools;
        };
      };
      # nixosConfigurations.radnas = machine arm64 "radnas" [ rockchip.nixosModules.sdImageRockchip ];

    };
}
