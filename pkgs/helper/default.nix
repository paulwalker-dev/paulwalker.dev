{ pkgs ? import <nixpkgs> { }, deploy-rs ? pkgs.deploy-rs }:
pkgs.writeShellScriptBin "sys" ''
  sys_rebuild() {
    if [ ! -f "/etc/NIXOS" ]; then
      echo "Not NixOS, cannot switch configs"
      exit 1
    fi

    configname="''${2:-$(hostname)}"

    "${pkgs.sudo}/bin/sudo" \
      "${pkgs.nixos-rebuild}/bin/nixos-rebuild" \
        "$1" --flake ".#$config_name"
  }

  sys_deploy() {
    "${deploy-rs}/bin/deploy"
  }

  sys_livecd() {
    "${pkgs.nix}/bin/nix" build \
      ".#nixosConfigurations.livecd.config.system.build.isoImage"
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
        sys_livecd
        ;;
      *)
        echo "No valid subcommand given"
        exit 1
        ;;
    esac
  }

  main $@
''
