{ lib, pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];
    # recommendedEnvironment = false;
    # nvidiaPatches = true;

    settings = {
      monitor = [ "preferred" "auto" "1" ];

      exec-once = [
        "$HOME/.config/hypr/autostart"
        "waybar"
        "dunst"
        "nm-applet"
      ];

      input = {
        kb_layout = "";
        kb_variant = "ffffff";
        kb_model = "";
        kb_options = "caps:escape";
        kb_rules = "";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = "no";
        };
      };

      misc = { };

      general = {
        gaps_in = 1;
        gaps_out = 1;
        border_size = 1;
        "col.active_border" = "0xfff5c2e7";
        "col.inactive_border" = "0xff45475a";
        "col.nogroup_border" = "0xff89dceb";
        "col.nogroup_border_active" = "0xfff9e2af";
      };

      decoration = {
        rounding = 15;
        blur = {
          enabled = true;
          new_optimizations = true;
          size = 1; # minimum 1
          passes = 1; # minimum 1, more passes = more resource intensive.
          # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
          # if you want heavy blur, you need to up the blur_passes.
          # the more passes, the more you can up the blur_size without noticing artifacts.
        };
      };

      animations = {
        enabled = 1;
        # bezier = "overshot,0.05,0.9,0.1,1.1";
        bezier = "overshot,0.13,0.99,0.29,1.1";
        animation = [
          "windows,1,4,overshot,slide"
          "border,1,10,default"
          "fade,1,10,default"
          "workspaces,1,6,overshot,slidevert"
        ];
      };

      dwindle = {
        pseudotile = 1; # enable pseudotiling on dwindle
        force_split = 0;
      };

      master = { };

      gestures = {
        workspace_swipe = "yes";
        workspace_swipe_fingers = 4;
      };

      # example window rules
      # for windows named/classed as abc and xyz
      # windowrule = "move 69 420,abc";
      windowrule = [
        "move center,title:^(fly_is_kitty)$"
        "size 800 500,title:^(fly_is_kitty)$"
        "animation slide,title:^(all_is_kitty)$"
        "float,title:^(all_is_kitty)$"
        # "tile,xy"
        "tile,title:^(kitty)$"
        "float,title:^(fly_is_kitty)$"
        "float,title:^(clock_is_kitty)$"
        "size 418 234,title:^(clock_is_kitty)$"
        # "pseudo,abc"
        # "monitor 0,xyz"
      ];

      # example binds
      "$mod" = "SUPER";

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # App Launcher binds
      bind = [
        "$mod, t, exec, kitty --start-as=fullscreen -o 'font_size=25' --title all_is_kitty"
        "$mod, RETURN, exec, kitty --title fly_is_kitty"
        "ALT, RETURN, exec, kitty --single-instance"
        ", Print, exec, ~/.config/hypr/scripts/screenshot"
        # "$mod, RETURN, exec, alacritty"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, F, exec, pcmanfm"
        "$mod, E, exec, zeditor"
        "$mod, C, exec, codium"
        "$mod, S, togglefloating,"
        "$mod, space, exec, rofi -show drun -o DP-3"
        "$mod, P, pseudo,"
        "$mod, L, exec, ~/.config/hypr/scripts/lock"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        # "CTRL, 1, workspace, 1"
        # "CTRL, 2, workspace, 2"
        # "CTRL, 3, workspace, 3"
        # "CTRL, 4, workspace, 4"
        # "CTRL, 5, workspace, 5"
        # "CTRL, 6, workspace, 6"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "ALT, 1, movetoworkspace, 1"
        "ALT, 2, movetoworkspace, 2"
        "ALT, 3, movetoworkspace, 3"
        "ALT, 4, movetoworkspace, 4"
        "ALT, 5, movetoworkspace, 5"
        "ALT, 6, movetoworkspace, 6"
        "ALT, 7, movetoworkspace, 7"
        "ALT, 8, movetoworkspace, 8"
        "ALT, 9, movetoworkspace, 9"
        "ALT, 0, movetoworkspace, 10"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        "$mod CTRL, up, workspace, e+1"
        "$mod CTRL, down, workspace, e-1"
        "$mod, g, togglegroup"
        "$mod, tab, changegroupactive"
        # rec
        "CTRL, 1, exec, kitty --title fly_is_kitty --hold cava"
        "CTRL, 2, exec, code"
        "CTRL, 3, exec, kitty --single-instance --hold donut.c"
        "CTRL, 4, exec, kitty --title clock_is_kitty --hold tty-clock -C5"
        # i3 window rules
        "ALT, R, submap, resize"
        "$mod, grave, hyperexpo:expo, toggle"
      ];

      submap = {
        resize = [
          ", right, resizeactive, 10 0"
          ", left, resizeactive, -10 0"
          ", up, resizeactive, 0 -10"
          ", down, resizeactive, 0 10"
        ];
        reset = [
          ", escape, submap, reset"
        ];
      };
      plugin = {
        hyprexpo = {
          columns = 3;
          gap_size = 5;
          bg_col = "rgb(111111)";
          workspace_method = "center current";
        };
      };
    };
  };
}
