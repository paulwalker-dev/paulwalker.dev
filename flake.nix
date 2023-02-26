{
  description = "A very basic flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.deploy-rs.url = "github:serokell/deploy-rs";
  inputs.deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, deploy-rs }:
    let
      system = "x86_64-linux";

      lib = import ./lib {
        inherit system;
        inherit nixpkgs;
        inherit deploy-rs;
        inherit (self) nixosConfigurations;
      };

      inherit (lib) mkConfig mkNode;
    in {
      nixosConfigurations = {
        #minecraft = mkConfig {
        #  inherit system;
        #  hostname = "minecraft";
        #  configName = "minecraft";
        #  hardware = "qemu";
        #};
        www = mkConfig {
          inherit system;
          hostname = "www";
          configName = "www";
          hardware = "qemu";
        };
      };

      deploy.nodes = {
        #minecraft = mkNode {
        #  hostname = "mc.paulwalker.dev";
        #  configName = "minecraft";
        #};
        www = mkNode {
          hostname = "www.paulwalker.dev";
          configName = "www";
        };
      };

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
