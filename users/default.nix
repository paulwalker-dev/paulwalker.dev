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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGhg55ucXI1rypBjMQBZXsqK2G6OP8sDt9NpAwx+Qms paulwalker@pauls-desktop"
    ];
  };
}
