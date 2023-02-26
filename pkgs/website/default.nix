{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "website";
  src = ./src;
  nativeBuildInputs = with pkgs; [ hugo ];
  phases = [ "buildPhase" ];
  buildPhase = ''
    tmpdir=$(mktemp -d)
    cp -r --no-preserve=mode,ownership $src $tmpdir/src
    hugo -s "$tmpdir/src" -d "$out"
    rm -rf $tmpdir
  '';
}
