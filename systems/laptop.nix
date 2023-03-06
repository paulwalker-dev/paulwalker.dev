{ config, pkgs, ... }: {
  imports = [ ./gnome.nix ];

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];

  networking.firewall.enable = true;
  networking.hosts = {
    "140.82.112.3" = [ "github.com" ];
    "13.33.4.2" = [ "crates.io" ];
  };
}
