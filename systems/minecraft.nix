{ lib, pkgs, ... }: {
  containers.minecraft = {
    ephemeral = true;
    autoStart = true;
    bindMounts = {
      "/var/lib/minecraft" = {
        hostPath = "/var/lib/minecraft";
        isReadOnly = false;
      };
    };
    config = { config, pkgs, ... }: {
      services.minecraft-server = {
        enable = true;
        eula = true;
        package = pkgs.papermc;
        openFirewall = true;
        declarative = true;
        whitelist = { linuxwizard = "e477fdce-a59b-413c-9030-466e86ffd3b4"; };
        serverProperties = {
          white-list = false;
          #enable-rcon = true;
          #"rcon.password" = import ../secrets/rcon.nix;
        };
      };
      networking.firewall.allowedTCPPorts = [ 25565 25575 ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 25565 25575 ];

  system.activationScripts.makeMinecraftDir = lib.stringAfter [ "var" ] ''
    mkdir -p /var/lib/minecraft
  '';
}
