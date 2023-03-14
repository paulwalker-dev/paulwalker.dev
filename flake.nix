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
        # Servers
        www = mkConfig {
          inherit system;
          hostname = "www";
          hardware = "vm";
          server = true;
        };

        # Personal computers
        desktop = mkConfig {
          inherit system;
          hostname = "desktop";
        };
        laptop = mkConfig {
          inherit system;
          hostname = "laptop";
        };

        # Deployment
        vm = mkConfig {
          inherit system;
          hostname = "vm";
          configName = "gnome";
        };
        livecd = mkConfig {
          inherit system;
          hostname = "livecd";
          configName = "gnome";
        };

        # Not amd64
        raspberrypi = mkConfig {
          system = "aarch64-linux";
          hostname = "raspberrypi";
          configName = "none";
        };
      };

      deploy.nodes = {
        www = mkNode {
          inherit system;
          hostname = "www.paulwalker.dev";
          configName = "www";
        };

        raspberrypi = mkConfig {
          system = "aarch64-linux";
          hostname = "raspberrypi";
          configName = "raspberrypi";
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
