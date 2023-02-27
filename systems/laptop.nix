{ config, pkgs, ... }: {
  imports = [ ./desktop.nix ];

  networking.firewall.enable = true;
  networking.hosts = {
    "140.82.112.3" = [ "github.com" ];
    "13.33.4.2" = [ "crates.io" ];
  };
}
