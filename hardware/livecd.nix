{ config, lib, modulesPath, users, ... }: {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-base.nix")
    (modulesPath + "installer/cd-dvd/channel.nix")
  ];

  networking.networkmanager.enable = false;

  users.users = builtins.mapAttrs (name: user: { password = "livecd"; }) users;
}
