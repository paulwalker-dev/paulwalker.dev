{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, deploy-rs, home-manager }:
    let
      system = "x86_64-linux";

      lib = import ./lib {
        inherit nixpkgs deploy-rs home-manager;
        inherit (self) nixosConfigurations;
      };

      inherit (lib) mkConfig mkNode;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        www = mkConfig {
          inherit system;
          hostname = "www";
          hardware = "onegrid";
        };
        staging = mkConfig {
          inherit system;
          hostname = "staging";
          hardware = "onegrid";
        };

        desktop = mkConfig {
          inherit system;
          hostname = "desktop";
          server = false;
        };
        laptop = mkConfig {
          inherit system;
          hostname = "laptop";
          server = false;
        };

        vm = mkConfig {
          inherit system;
          hostname = "vm";
          configName = "gnome";
          hardware = "onegrid";
          server = false;
        };
        livecd = mkConfig {
          inherit system;
          hostname = "livecd";
          configName = "gnome";
          server = false;
        };
      };

      deploy.nodes = {
        www = mkNode {
          inherit system;
          hostname = "www.paulwalker.dev";
          configName = "www";
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixfmt
          hugo
          deploy-rs.packages.${system}.deploy-rs
          (import ./pkgs/helper {
            inherit pkgs;
            inherit (deploy-rs.packages.${system}) deploy-rs;
          })
        ];
      };

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
