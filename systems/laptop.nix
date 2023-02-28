{ config, pkgs, ... }: {
  imports = [ ./gnome.nix ];

  networking.networkmanager.ethernet.macAddress = "random";
  networking.firewall.enable = true;
  networking.hosts = {
    "140.82.112.3" = [ "github.com" ];
    "13.33.4.2" = [ "crates.io" ];
  };
}
