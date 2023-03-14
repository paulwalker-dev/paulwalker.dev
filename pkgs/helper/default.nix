{ pkgs ? import <nixpkgs> { }, deploy-rs ? pkgs.deploy-rs }:
pkgs.writeShellScriptBin "sys" ''
  sys_rebuild() {
    if [ ! -f "/etc/NIXOS" ]; then
      echo "Not NixOS, cannot switch configs"
      exit 1
    fi

    configname="''${2:-$(hostname)}"

    sudo "${pkgs.nixos-rebuild}/bin/nixos-rebuild" \
      "$1" --flake ".#$configname"
  }

  sys_deploy() {
    "${deploy-rs}/bin/deploy"
  }

  sys_build() {
    "${pkgs.nix}/bin/nix" build \
      ".#nixosConfigurations.$1.config.system.build.$2"
  }

  main() {
    SUBCMD="$1"

    case "$1" in
      switch)
        sys_rebuild switch "$2"
        ;;
      boot)
        sys_rebuild boot "$2"
        ;;
      deploy)
        sys_deploy
        ;;
      livecd)
        sys_build livecd isoImage
        ;;
      vm)
        sys_build vm vm
        ;;
      rpi)
        sys_build raspberrypi sdImage
        ;;
      *)
        echo "No valid subcommand given"
        exit 1
        ;;
    esac
  }

  main $@
''
