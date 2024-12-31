  {config, inputs, pkgs, ...}:

{
  # Hyprland
  programs.hyprland = {
    enable = true;
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
    hyprland-workspaces
    hyprlandPlugins.hyprexpo
  ];
}
