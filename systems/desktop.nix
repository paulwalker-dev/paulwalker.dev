{ config, pkgs, ... }: {
  imports = [ ./gnome.nix ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nixpkgs.config.allowUnfree = true;
  hardware.xpadneo.enable = true;
  programs.steam.enable = true;

  ## Virtualization
  # Hypervisor
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Programs
  environment.systemPackages = with pkgs; [ virt-manager discord ];
}
