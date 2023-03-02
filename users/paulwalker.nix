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

    neovim = {
      enable = true;
      vimAlias = true;
      coc.enable = true;
      extraConfig = ''
        set expandtab
        set shiftwidth=4
        set tabstop=4
        set nu rnu
        colorscheme monokai
      '';
      plugins = with pkgs.vimPlugins; [ vim-polyglot vim-monokai ];
    };
  };

  home.stateVersion = "22.11";
}
