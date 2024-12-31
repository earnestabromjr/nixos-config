  {config, inputs, pkgs, ...}:

{
  # Hyprland
  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland
    xwayland.enable = true;
  };
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
    gbm
    hyprland-protocols
    hyprland
    hyprutils
    hyprwayland-scanner
    hyprland-workspaces
    hyprlandPlugins.hyprexpo
    libdrm
    libpipewire-0.3
    libpsa-0.2
    wayland-client
    wayland-protocols
  ];
}
