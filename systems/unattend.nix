{ hostname, ... }: {
  system.autoUpgrade = {
    enable = true;
    flake = "github:paulwalker-dev/paulwalker.dev#${hostname}";
    dates = "daily";
    allowReboot = true;
    persistent = true;
    rebootWindow = {
      lower = "22:00";
      upper = "02:00";
    };
  };
}
