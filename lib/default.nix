{ system, nixpkgs, deploy-rs, nixosConfigurations }: {
  mkConfig = { hostname, configName, hardware, qemu ? false, ... }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ../common.nix
        ../systems/${configName}.nix
        { networking.hostName = hostname; }
      ] ++ (if qemu then
        [ "${nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix" ]
      else
        [ ../hardware/${hardware}.nix ]);
    };

  mkNode = { hostname, sshOpts ? [ ], configName, ... }:
    let nixosConfig = nixosConfigurations.${configName};
    in {
      inherit hostname;
      profiles = {
        system = {
          inherit sshOpts;
          sshUser = "admin";
          path = deploy-rs.lib.${system}.activate.nixos nixosConfig;
          user = "root";
        };
      };
    };
}
