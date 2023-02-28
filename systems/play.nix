{ lib, pkgs, ... }: {
  imports = [ ./www.nix ];

  containers = {
    terraria = {
      ephemeral = true;
      autoStart = true;
      bindMounts = {
        "/var/lib/terraria" = {
          hostPath = "/var/lib/terraria";
          isReadOnly = false;
        };
      };
      config = { pkgs, ... }: {
        services.terraria = {
          enable = true;
          secure = true;
          worldPath = /var/lib/terraria/server.wld;
          maxPlayers = 4;
        };

        environment.systemPackages = with pkgs; [ tmux ];

        nixpkgs.config.allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [ "terraria-server" ];

        networking.firewall.allowedTCPPorts = [ 7777 ];
      };
    };

    minecraft = {
      ephemeral = true;
      autoStart = true;
      bindMounts = {
        "/var/lib/minecraft" = {
          hostPath = "/var/lib/minecraft";
          isReadOnly = false;
        };
      };
      config = { pkgs, ... }: {
        services.minecraft-server = {
          enable = true;
          eula = true;
          package = pkgs.papermc;
          declarative = true;
          serverProperties = {
            enable-rcon = true;
            "rcon.password" = "password";
          };
        };

        environment.systemPackages = with pkgs; [ rcon ];
        networking.firewall.allowedTCPPorts = [ 25565 ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 7777 25565 ];

  system.activationScripts = {
    makeTerrariaDir = lib.stringAfter [ "var" ] ''
      mkdir -p /var/lib/terraria
    '';

    makeMinecraftDir = lib.stringAfter [ "var" ] ''
      mkdir -p /var/lib/minecraft
    '';
  };
}
