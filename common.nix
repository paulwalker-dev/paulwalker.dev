{ lib, pkgs, ... }: {
  nix.settings.trusted-users = [ "@wheel" ];

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = import ./secrets/password.nix;
    openssh.authorizedKeys.keys = import ./secrets/keys.nix;
  };

  services.openssh.enable = true;

  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "paulwalker@paulwalker.dev";
}
