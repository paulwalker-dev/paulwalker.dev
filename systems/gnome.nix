{ config, pkgs, ... }: {
  networking.enableIPv6 = false;

  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    settings."org/gnome/login-screen".disable-user-list = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
