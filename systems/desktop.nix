{ config, pkgs, ... }: {
  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  fonts.enableDefaultFonts = true;

  security.polkit.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [ steam ];
}
