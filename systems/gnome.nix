{ config, pkgs, ... }: {
  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.flatpak.enable = true;
}
