{ options, lib, ... }:
lib.mkIf (options ? virtualisation.memorySize) {
  users.users.root.password = "root";
}
