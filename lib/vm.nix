{ users }:
({ options, lib, ... }:
  lib.mkIf (options ? virtualisation.memorySize) {
    users.users =
      builtins.mapAttrs (name: user: { password = "password"; }) users;
  })
