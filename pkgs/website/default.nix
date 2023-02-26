{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation rec {
  pname = "website";
  version = "1.0";
  srcs = with pkgs; [
    ./src
    (fetchFromGitHub {
      owner = "panr";
      repo = "hugo-theme-terminal";
      rev = "2b14b3d4e5eab53aa45647490bb797b642a82a59";
      name = "terminal";
      sha256 = "EkAH6p5vG4S1eEQqtT8OrvK1ldZKmJPwkWC28RM45K4=";
    })
  ];
  sourceRoot = "src";
  nativeBuildInputs = with pkgs; [ hugo ];
  phases = [ "unpackPhase" "buildPhase" ];
  buildPhase = ''
    tmpdir=$(mktemp -d)
    cp -r --no-preserve=mode,ownership . $tmpdir/src
    cp -r --no-preserve=mode,ownership ../terminal $tmpdir/src/themes
    hugo -s "$tmpdir/src" -d "$out"
    rm -rf $tmpdir
  '';
}
