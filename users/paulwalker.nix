{ config, pkgs, ... }: {
  home.username = "paulwalker";
  home.homeDirectory = "/home/paulwalker";

  home.packages = with pkgs; [ firefox ];

  programs.vim = {
    enable = true;
    extraConfig = "colorscheme onedark";
    plugins = with pkgs.vimPlugins; [ vim-polyglot onedark-vim ];
    settings = {
      expandtab = true;
      shiftwidth = 4;
      tabstop = 4;
      relativenumber = true;
      number = true;
    };
  };

  home.stateVersion = "22.11";
}
