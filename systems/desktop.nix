{ config, pkgs, ... }: {
  imports = [ ./gnome.nix ];

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];
}
