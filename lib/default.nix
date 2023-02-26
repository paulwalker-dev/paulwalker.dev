{ system, nixpkgs, deploy-rs, nixosConfigurations }: {
  mkConfig = { hostname, configName, hardware, ... }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ../common.nix
        ../systems/${configName}.nix
        ../hardware/${hardware}.nix
        { networking.hostName = hostname; }
      ];
    };

  mkNode = { hostname, configName, ... }:
    let nixosConfig = nixosConfigurations.${configName};
    in {
      inherit hostname;
      profiles = {
        system = {
          sshUser = "admin";
          path = deploy-rs.lib.${system}.activate.nixos nixosConfig;
          user = "root";
        };
      };
    };
}
