{ lib, pkgs, ... }: {
  nix.settings.trusted-users = [ "@wheel" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.cleanTmpDir = true;

  time.timeZone = "US/Eastern";

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  security.sudo.extraRules = [{
    users = [ "admin" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "paulwalker@paulwalker.dev";

  environment.systemPackages = with pkgs; [ vim git ];

  system.stateVersion = "22.11";
}
