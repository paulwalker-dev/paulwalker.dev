{ users, hostname }:
({ lib, pkgs, ... }: {
  services.borgbackup.jobs = builtins.mapAttrs (name: user: {
    user = "${user.username}";
    paths = "/home/${user.username}/data";
    encryption.mode = "none";
    repo = "borg@backup.paulwalker.dev:${hostname}";
    compression = "auto,zstd";
    startAt = "daily";
  }) (lib.filterAttrs (n: user: user.backup) users);
})
