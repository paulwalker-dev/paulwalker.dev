{ config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/sd-card/sd-image-aarch64.nix") ];
  config.system.build.sdImage.compressImage = false;
}
