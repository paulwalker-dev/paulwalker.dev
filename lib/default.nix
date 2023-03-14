{ nixpkgs, deploy-rs, home-manager, nixosConfigurations }: {
  mkConfig = { system, hostname, configName ? hostname, hardware ? hostname
    , server ? false, remote ? server, ... }:
    let users = import ../users;
    in nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit users; };
      modules = [
        ../common.nix
        ../systems/${configName}.nix
        ../hardware/${hardware}.nix
        { networking.hostName = hostname; }
        (import ./vm.nix { inherit users; })
      ] ++ (if remote then [{
        users.users.admin.openssh.authorizedKeys.keys = builtins.concatLists
          (nixpkgs.lib.mapAttrsToList (name: user: user.ssh)
            (nixpkgs.lib.filterAttrs (name: user: user.admin) users));
      }] else
        [ ]) ++ (if server then [{
          users.mutableUsers = false;
        }] else [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users =
              builtins.mapAttrs (name: user: user.config) users;

            users.users = builtins.mapAttrs (name: user: {
              isNormalUser = true;
              extraGroups = if user.admin then [ "wheel" ] else [ ];
              openssh.authorizedKeys.keys = user.ssh;
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
