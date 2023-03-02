{ lib, pkgs, ... }: {
  imports = [ ./backup.nix ];

  services.nginx = {
    enable = true;
    virtualHosts."www.paulwalker.dev" = {
      addSSL = true;
      enableACME = true;
      root = import ../pkgs/website { inherit pkgs; };
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
}
