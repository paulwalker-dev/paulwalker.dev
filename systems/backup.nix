{ lib, pkgs, ... }:
let users = import ../users;
in {
  services.borgbackup.repos = builtins.mapAttrs (name: user: {
    path = "/srv/borg/${user.username}";
    authorizedKeys = user.ssh;
    allowSubRepos = true;
  }) (lib.filterAttrs (n: user: user.backup) users);

  networking.firewall.allowedTCPPorts = [ 22 ];
}
