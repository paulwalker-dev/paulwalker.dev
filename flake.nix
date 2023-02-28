{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, deploy-rs, home-manager }:
    let
      system = "x86_64-linux";

      lib = import ./lib {
        inherit system;
        inherit nixpkgs deploy-rs home-manager;
        inherit (self) nixosConfigurations;
      };

      inherit (lib) mkConfig mkNode;
    in {
      nixosConfigurations = {
        www = mkConfig {
          inherit system;
          hostname = "www";
          configName = "www";
          hardware = "onegrid";
        };
        play = mkConfig {
          inherit system;
          hostname = "play";
          configName = "play";
          hardware = "onegrid";
        };

        pauls-desktop = mkConfig {
          inherit system;
          hostname = "pauls-desktop";
          configName = "desktop";
          hardware = "desktop";
          server = false;
        };
        pauls-laptop = mkConfig {
          inherit system;
          hostname = "";
          configName = "laptop";
          hardware = "laptop";
          server = false;
        };
      };

      deploy.nodes = {
        www = mkNode {
          hostname = "www.paulwalker.dev";
          configName = "www";
        };
        #play = mkNode {
        #  hostname = "play.paulwalker.dev";
        #  configName = "play";
        #  magicRollback = false;
        #};
      };

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
