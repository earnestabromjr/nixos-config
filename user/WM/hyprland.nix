{ lib, pkgs, inputs, ... }: {
    imports = [ inputs.hyprland-nix.homeManagerModules.default ];

    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        reloadConfig = true;
        systemdIntegration = true;
        # recommendedEnvironment = false;
        # nvidiaPatches = true;

        config = {
            # ...
        };
        # ...
    };
    # ...
}
