{ lib, pkgs, ... }: {
  services.nginx = {
    enable = true;
    virtualHosts."staging.paulwalker.dev" = {
      addSSL = true;
      enableACME = true;
      root = import ../pkgs/website { inherit pkgs; };
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
}
