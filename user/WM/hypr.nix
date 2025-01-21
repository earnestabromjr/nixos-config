{ config, pkgs, ... }

{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hyprexpo
    ];
  };

  home.file = {
    ".config/hypr" = {
      source = ./hypr;  # Path relative to your configuration file
      recursive = true;  # Include all files in the directory
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
