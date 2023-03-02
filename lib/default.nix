{ nixpkgs, deploy-rs, home-manager, nixosConfigurations }: {
  mkConfig = { system, hostname, configName, hardware, server ? true, ... }:
    let users = import ../users;
    in nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./vm.nix
        ../common.nix
        ../systems/${configName}.nix
        ../hardware/${hardware}.nix
        { networking.hostName = hostname; }
      ] ++ (if server then
        [ ]
      else [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users =
            builtins.mapAttrs (name: user: user.config) users;

          users.users = builtins.mapAttrs (name: user: {
            isNormalUser = true;
            extraGroups = if user.admin then [ "wheel" ] else [ ];
          }) users;
        }
      ]);
    };

  mkNode = { system, hostname, magicRollback ? true, configName, ... }:
    let nixosConfig = nixosConfigurations.${configName};
    in {
      inherit hostname;
      profiles = {
        system = {
          inherit magicRollback;
          sshUser = "admin";
          path = deploy-rs.lib.${system}.activate.nixos nixosConfig;
          user = "root";
        };
      };
    };
}
