{ config, pkgs, ... }: {
  imports = [ ./gnome.nix ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    steam-run = (pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [ bzip2 networkmanager ];
    }).run;
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [ bzip2 networkmanager ];
    };
  };

  hardware.xpadneo.enable = true;
  programs.steam.enable = true;

  ## Virtualization
  # Hypervisor
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];
}
