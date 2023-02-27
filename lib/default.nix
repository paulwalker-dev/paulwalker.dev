{ system, nixpkgs, deploy-rs, home-manager, nixosConfigurations }: {
  mkConfig = { hostname, configName, hardware, server ? false, ... }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
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
            builtins.mapAttrs (name: user: user.config) (import ../users);

          users.users = builtins.mapAttrs (name: user: {
            isNormalUser = true;
            extraGroups = if user.admin then [ "wheel" ] else [ ];
          }) (import ../users);
        }
      ]);
    };

  mkNode = { hostname, magicRollback ? true, configName, ... }:
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
