let
  mkUser = { username, admin ? false }: {
    inherit username admin;
    config = import ./${username}.nix;
  };
in {
  paulwalker = mkUser {
    username = "paulwalker";
    admin = true;
  };
}
