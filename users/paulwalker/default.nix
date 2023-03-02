{ config, pkgs, lib, ... }: {
  home.username = "paulwalker";
  home.homeDirectory = "/home/paulwalker";

  home.packages = with pkgs; [
    asciinema
    pstree
    firefox
    # Games
    #prismlauncher
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" =
        let wallpaper = ./wallpaper.jpg;
        in rec {
          picture-uri = "${wallpaper}";
          picture-uri-dark = picture-uri;
        };
    };
  };

  programs = {
    alacritty.enable = true;
    bash.enable = true;

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    git = {
      enable = true;
      userName = "Paul Walker";
      userEmail = "paulwalker@paulwalker.dev";
    };

    vim = {
      enable = true;
      extraConfig = "colorscheme monokai";
      plugins = with pkgs.vimPlugins; [ vim-polyglot vim-monokai vim-surround ];
      settings = {
        expandtab = true;
        shiftwidth = 4;
        tabstop = 4;
        number = true;
        relativenumber = true;
      };
    };
  };

  home.stateVersion = "22.11";
}
