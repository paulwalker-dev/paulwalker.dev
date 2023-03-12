{ config, lib, modulesPath, users, ... }: {
  imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

  networking.networkmanager.enable = false;

  users.users = builtins.mapAttrs (name: user: { password = "livecd"; }) users;
}
