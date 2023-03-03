{ config, pkgs, lib, ... }: {
  home.username = "paulwalker";
  home.homeDirectory = "/home/paulwalker";

  home.packages = with pkgs; [
    asciinema
    pstree
    # Gui apps
    chromium
    # Games
    prismlauncher
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

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

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
        shiftwidth = 4;
        tabstop = 4;
        number = true;
        relativenumber = true;
      };
    };
  };

  home.stateVersion = "22.11";
}
