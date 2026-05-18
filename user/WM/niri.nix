{
  config,
  lib,
  pkgs,
  ...
}:

{
  # We enable niri here.
  # The configuration files are sourced via xdg.configFile below.
  programs.niri.enable = true;

  # Source the niri configuration from our local niri-config directory
  xdg.configFile."niri".source = ./niri-config;

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    GDK_BACKEND = "wayland,x11";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    ELECTRON_USE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  home.packages = with pkgs; [
    # Add any niri-specific packages here if they aren't in system packages
    xwayland-satellite
    wl-clipboard
    swaybg
  ];
}
