{ config, pkgs, lib, ... }: {
  home.username = "paulwalker";
  home.homeDirectory = "/home/paulwalker";

  home.packages = with pkgs; [ bottles pstree firefox ];

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      keybindings = lib.mkOptionDefault {
        "XF86AudioRaiseVolume" =
          "exec wpctl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" =
          "exec wpctl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec wpctl set-sink-mute @DEFAULT_SINK@ toggle";
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
      plugins = with pkgs.vimPlugins; [ vim-polyglot vim-monokai ];
      settings = {
        expandtab = true;
        shiftwidth = 4;
        tabstop = 4;
        relativenumber = true;
        number = true;
      };
    };
  };

  home.stateVersion = "22.11";
}
