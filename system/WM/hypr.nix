  {config, inputs, pkgs, ...}:

{
  # Hyprland
  programs.hyprland = {
    enable = true;
   # portalPackage = pkgs.xdg-desktop-portal-hyprland;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };
  programs = {
    nm-applet.indicator = true;
  };
  service.hypridle.enable = true;
  environment.systemPackages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    })
    )
    rofi-wayland
    waybar
    dunst
    pcmanfm
    libnotify
    swww
    hyprland-protocols
    hyprland
    hyprlock
    hyprutils
    hyprwayland-scanner
    hyprland-workspaces
    hyprlandPlugins.hyprexpo
    libdrm
    wayland-protocols
    dconf
    cmake
    meson
    cpio
  ];
}
