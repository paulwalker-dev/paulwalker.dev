{ config, pkgs, lib, ... }: {
  home.username = "paulwalker";
  home.homeDirectory = "/home/paulwalker";

  home.packages = with pkgs; [
    asciinema
    pstree
    # Internet
    chromium
    firefox
    # Why is this not included
    file
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = {
        picture-uri = "${./wallpaper.jpg}";
        picture-uri-dark = "${./wallpaper.jpg}";
      };
      "org/gnome/desktop/interface" = {
        clock-format = "12h";
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus";
  };

  programs = {
    bash.enable = true;
    fzf.enable = true;
    starship.enable = true;

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    alacritty = {
      enable = true;
      settings = {
        window.dimensions = {
          columns = 80;
          lines = 24;
        };
        font.size = 10;
      };
    };

    git = {
      enable = true;
      userName = "Paul Walker";
      userEmail = "paulwalker@paulwalker.dev";
    };

    vim = {
      enable = true;
      extraConfig = ''
        let mapleader=" "
        nnoremap <SPACE> <Nop>

        nnoremap <LEADER>o <CMD>FZF<CR>

        set shiftwidth=4
        set tabstop=4

        colorscheme monokai
      '';
      plugins = with pkgs.vimPlugins; [
        vim-polyglot
        vim-monokai
        vim-surround
        fzf-vim
      ];
      settings = {
        expandtab = true;
        number = true;
        relativenumber = true;
      };
    };
  };

  home.stateVersion = "22.11";
}
