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

    vim = {
      enable = true;
      extraConfig = "colorscheme monokai";
      plugins = with pkgs.vimPlugins; [ vim-polyglot vim-monokai ];
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
