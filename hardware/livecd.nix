{ config, lib, modulesPath, users, ... }: {
  imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-base.nix") ];

  networking.networkmanager.enable = false;

  users.users = builtins.mapAttrs (name: user: { password = "livecd"; }) users;
}
