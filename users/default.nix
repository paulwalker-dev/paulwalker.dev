let
  mkUser = { username, admin ? false, backup ? false, ssh ? [ ] }: {
    inherit username admin backup ssh;
    config = import ./${username};
  };
in {
  paulwalker = mkUser {
    username = "paulwalker";
    admin = true;
    backup = true;
    ssh = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7DXKJns7+SW4Vff4R8TofQP2ReyyHy9iVH+ybFgE24"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM53A1rjoG2cQxo9cf6PRBXfqO1bgTkO8elohJm4iZVY"
    ];
  };
}
