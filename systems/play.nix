{ lib, pkgs, ... }: {
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
      config = { config, pkgs, ... }: {
        services.terraria = {
          enable = true;
          secure = true;
          worldPath = /var/lib/terraria/server.wld;
          maxPlayers = 4;
        };

        environment.systemPackages = with pkgs; [ tmux ];

        nixpkgs.config.allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [ "terraria-server" ];

        networking.firewall.allowedTCPPorts = [ 22 7777 ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 7777 ];

  system.activationScripts.makeTerrariaDir = lib.stringAfter [ "var" ] ''
    mkdir -p /var/lib/terraria
  '';
}
