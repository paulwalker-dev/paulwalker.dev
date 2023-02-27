{ lib, pkgs, ... }: {
  nix.settings.trusted-users = [ "@wheel" ];

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
}
