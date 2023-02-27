{ lib, pkgs, ... }: {
  nix.settings.trusted-users = [ "@wheel" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "US/Eastern";

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.openssh.enable = true;

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
}
