{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf;
in
{
  wayland.windowManager.mango = {
    enable = true;

    autostart_sh = ''
      # mangowc autostart
      dms run &
      swaync >/dev/null 2>&1 &
      if ! dms ipc call wallpaper get >/dev/null 2>&1; then
        swaybg -i ~/Pictures/wallpapers/wallhaven-purpleworld.jpg >/dev/null 2>&1 &
      fi
      /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 >/dev/null 2>&1 || \
      /usr/lib/xfce-polkit/xfce-polkit >/dev/null 2>&1 &
      wl-clip-persist --clipboard regular >/dev/null 2>&1 &
      /usr/lib/xdg-desktop-portal-wlr >/dev/null 2>&1 &
    '';

    settings = {
      # ---- Visual Effects ----
      blur = 1;
      blur_layer = 1;
      blur_optimized = 1;
      blur_params = {
        radius = 5;
        num_passes = 2;
        noise = 0.02;
        brightness = 0.9;
        contrast = 0.9;
        saturation = 1.2;
      };
      shadows = 1;
      layer_shadows = 1;
      shadow_only_floating = 1;
      shadows_size = 12;
      shadows_blur = 15;
      shadows_position_x = 0;
      shadows_position_y = 0;
      shadowscolor = "0x000000ff";
      border_radius = 6;
      no_radius_when_single = 0;
      focused_opacity = 1.0;
      unfocused_opacity = 0.85;

      # ---- Animations ----
      animations = 1;
      layer_animations = 1;
      animation_type_open = "slide";
      animation_type_close = "slide";
      layer_animation_type_open = "slide";
      layer_animation_type_close = "slide";
      animation_fade_in = 1;
      animation_fade_out = 1;
      tag_animation_direction = 1;
      zoom_initial_ratio = 0.4;
      zoom_end_ratio = 0.7;
      fadein_begin_opacity = 0.8;
      fadeout_begin_opacity = 0.8;
      animation_duration_move = 500;
      animation_duration_open = 400;
      animation_duration_tag = 350;
      animation_duration_close = 800;
      animation_duration_focus = 400;
      animation_curve = {
        open = "0.46,1.0,0.29,1.1";
        move = "0.46,1.0,0.29,1";
        tag = "0.46,1.0,0.29,1";
        close = "0.08,0.92,0,1";
        focus = "0.46,1.0,0.29,1";
        opafadeout = "0.58,0.98,0.58,0.98";
        opafadein = "0.46,1.0,0.29,1";
      };

      # ---- Window Management ----
      new_is_master = 1;
      smartgaps = 0;
      default_mfact = 0.55;
      default_nmaster = 1;
      no_border_when_single = 0;
      enable_floating_snap = 1;
      snap_distance = 50;
      drag_tile_to_tile = 1;
      single_scratchpad = 1;
      scratchpad_width_ratio = 0.8;
      scratchpad_height_ratio = 0.9;

      # ---- Scroller Layout ----
      scroller_structs = 20;
      scroller_default_proportion = 0.8;
      scroller_focus_center = 0;
      scroller_prefer_center = 1;
      edge_scroller_pointer_focus = 1;
      scroller_ignore_proportion_single = 1;
      scroller_default_proportion_single = 1.0;
      scroller_proportion_preset = "0.5,0.8,1.0";

      # ---- Dwindle Layout ----
      dwindle_smart_split = 0;
      dwindle_drop_simple_split = 1;
      dwindle_manual_split = 0;
      dwindle_hsplit = 1;
      dwindle_vsplit = 1;
      dwindle_preserve_split = 1;

      # ---- Overview ----
      enable_hotarea = 1;
      hotarea_size = 10;
      ov_tab_mode = 0;
      overviewgappi = 5;
      overviewgappo = 30;

      # ---- System ----
      xwayland_persistence = 1;
      syncobj_enable = 0;
      axis_bind_apply_timeout = 100;
      focus_on_activate = 1;
      sloppyfocus = 1;
      warpcursor = 1;
      focus_cross_monitor = 0;
      focus_cross_tag = 0;
      cursor_hide_timeout = 0;
      cursor_size = 24;
      cursor_theme = "Bibata-Modern-Ice";

      # ---- Input ----
      repeat_rate = 25;
      xkb_rules_options = "caps:swapescape";
      repeat_delay = 600;
      numlockon = 1;
      disable_trackpad = 0;
      tap_to_click = 1;
      tap_and_drag = 1;
      drag_lock = 1;
      mouse_natural_scrolling = 0;
      trackpad_natural_scrolling = 0;
      disable_while_typing = 1;
      left_handed = 0;
      middle_button_emulation = 0;
      swipe_min_threshold = 1;
      mouse_accel_profile = 2;
      mouse_accel_speed = 0.0;

      # ---- Colors (Tokyo Night) ----
      rootcolor = "0x1a1b26ff";
      bordercolor = "0x32344aff";
      focuscolor = "0x7aa2f7ff";
      urgentcolor = "0xf7768eff";
      dropcolor = "0x0db9d733";
      splitcolor = "0xf7768eff";
      maximizescreencolor = "0x9ece6aff";
      scratchpadcolor = "0xbb9af7ff";
      globalcolor = "0xad8ee6ff";
      overlaycolor = "0x0db9d7ff";

      # ---- Dimensions ----
      gappih = 5;
      gappiv = 5;
      gappoh = 15;
      gappov = 15;
      borderpx = 4;

      # ---- Environment Variables ----
      env = [
        "XDG_CURRENT_DESKTOP,mangowm"
        "XDG_SESSION_TYPE,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "GDK_BACKEND,wayland,x11"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "ELECTRON_USE_WAYLAND,1"
        "NIXOS_OZONE_WL,1"
        "_JAVA_AWT_WM_NONREPARENTING,1"
        "GTK_IM_MODULE,fcitx"
        "QT_IM_MODULE,fcitx"
        "SDL_IM_MODULE,fcitx"
        "XMODIFIERS,@im=fcitx"
        "GLFW_IM_MODULE,ibus"
      ];

      # ---- Window Rules ----
      windowrule = [
        # Floating
        "isfloating:1,appid:pavucontrol"
        "isfloating:1,appid:blueman-manager"
        "isfloating:1,appid:nm-connection-editor"
        "isfloating:1,appid:org.gnome.Calculator"
        "isfloating:1,appid:org.gnome.Loupe"
        "isfloating:1,appid:imv"
        "isfloating:1,appid:mpv"
        "isfloating:1,title:Picture-in-Picture"
        "isfloating:1,title:pinentry"
        "isfloating:1,width:400,height:300,appid:pinentry-gtk-2"
        "isfloating:1,width:480,height:360,appid:firefox,title:Picture-in-Picture"

        # Steam
        "isfloating:1,appid:steam,title:^$"
        "isfloating:1,appid:steam,title:Steam Guard"

        # Global windows
        "isglobal:1,appid:waybar"

        # Opacity
        "focused_opacity:1.0,appid:foot"
        "unfocused_opacity:0.85,appid:foot"

        # No blur
        "noblur:1,appid:slurp"
        "noblur:1,appid:grim"
        "noblur:1,appid:wlogout"
        "noblur:1,appid:rofi"

        # No shadow
        "isnoshadow:1,appid:waybar"
        "isnoshadow:1,appid:slurp"

        # No border
        "isnoborder:1,appid:waybar"
        "isnoborder:1,appid:dms"

        # No radius
        "isnoradius:1,appid:waybar"

        # Terminal swallowing
        "isterm:1,appid:foot"
        "isterm:1,appid:alacritty"
        "isterm:1,appid:kitty"
        "isterm:1,appid:st"
      ];

      # ---- Tag Rules ----
      tagrule = [
        "id:1,layout_name:tile"
        "id:2,layout_name:tile"
        "id:3,layout_name:scroller"
        "id:4,layout_name:grid"
        "id:5,layout_name:monocle"
        "id:6,layout_name:deck"
        "id:7,layout_name:center_tile"
        "id:8,layout_name:vertical_tile"
        "id:9,layout_name:scroller"
        "id:1,no_hide:1,layout_name:tile"
        "id:2,no_hide:1,layout_name:tile"
        "id:3,no_hide:1,layout_name:scroller"
        "id:4,no_hide:1,layout_name:grid"
        "id:5,no_hide:1,layout_name:monocle"
        "id:1,nmaster:1,mfact:0.55"
        "id:2,nmaster:2,mfact:0.60"
        "id:7,nmaster:1,mfact:0.50"
      ];

      # ---- Layer Rules ----
      layerrule = [
        "noblur:1,layer_name:selection"
        "noanim:0,noblur:1,layer_name:rofi"
      ];

      # ---- Key Bindings ----
      # Modifier reference: SUPER, CTRL, ALT, SHIFT, NONE
      # Flags: l=locked, s=keysym, r=release, p=pass
      bind = [
        # Common (all modes)
        "SUPER,r,reload_config"

        # Application launchers
        "ALT,Return,spawn,foot"
        "ALT,d,spawn,foot -e yazi"
        "SUPER,d,spawn,rofi -show drun"
        "ALT,b,spawn,firefox"
        "SUPER,Return,spawn,ghostty"
        "CTRL+ALT,t,spawn,foot"
        "SUPER+SHIFT,Return,spawn,alacritty"

        # DMS Integration
        "SUPER,space,spawn,dms ipc call launcher toggle"
        "SUPER+SHIFT,space,spawn,dms ipc call spotlight toggle"
        "SUPER+SHIFT,v,spawn,dms ipc call clipboard toggle"
        "SUPER+SHIFT,n,spawn,dms ipc call notifications toggle"
        "SUPER+SHIFT,s,spawn,dms ipc call settings toggle"
        "SUPER+SHIFT,p,spawn,dms ipc call powermenu toggle"
        "SUPER+SHIFT,w,spawn,dms ipc call dankdash wallpaper"
        "SUPER+SHIFT,l,spawn,dms ipc call lock lock"
        "SUPER+SHIFT,m,spawn,dms ipc call mux toggle"
        "SUPER+SHIFT,o,spawn,dms ipc call notepad toggle"

        # Window management
        "ALT,q,killclient"
        "SUPER,f,togglefullscreen"
        "ALT,f,togglefloating"
        "SUPER+SHIFT,f,togglefakefullscreen"
        "SUPER+SHIFT,x,toggle_all_floating"
        "SUPER,w,togglemaximizescreen"
        "ALT,c,centerwin"
        "SUPER,t,toggleoverview"
        "SUPER+SHIFT,t,toggle_render_border"
        "SUPER+CTRL,space,toggleoverlay"
        "ALT+SHIFT,space,toggleglobal"

        # Tag navigation (Alt)
        "ALT,1,view,1"
        "ALT,2,view,2"
        "ALT,3,view,3"
        "ALT,4,view,4"
        "ALT,5,view,5"
        "ALT,6,view,6"
        "ALT,7,view,7"
        "ALT,8,view,8"
        "ALT,9,view,9"
        "ALT,0,view,0"

        # Tag navigation (Ctrl)
        "CTRL,1,view,1"
        "CTRL,2,view,2"
        "CTRL,3,view,3"
        "CTRL,4,view,4"
        "CTRL,5,view,5"
        "CTRL,6,view,6"
        "CTRL,7,view,7"
        "CTRL,8,view,8"
        "CTRL,9,view,9"

        # Prev/next tag
        "SUPER,Tab,viewtoleft"
        "SUPER+SHIFT,Tab,viewtoright"

        # Move window to tag
        "ALT+SHIFT,1,tag,1"
        "ALT+SHIFT,2,tag,2"
        "ALT+SHIFT,3,tag,3"
        "ALT+SHIFT,4,tag,4"
        "ALT+SHIFT,5,tag,5"
        "ALT+SHIFT,6,tag,6"
        "ALT+SHIFT,7,tag,7"
        "ALT+SHIFT,8,tag,8"
        "ALT+SHIFT,9,tag,9"
        "CTRL+SHIFT,1,tag,1"
        "CTRL+SHIFT,2,tag,2"
        "CTRL+SHIFT,3,tag,3"
        "CTRL+SHIFT,4,tag,4"
        "CTRL+SHIFT,5,tag,5"
        "CTRL+SHIFT,6,tag,6"
        "CTRL+SHIFT,7,tag,7"
        "CTRL+SHIFT,8,tag,8"
        "CTRL+SHIFT,9,tag,9"

        # Focus direction
        "ALT,Left,focusdir,left"
        "ALT,Right,focusdir,right"
        "ALT,Up,focusdir,up"
        "ALT,Down,focusdir,down"
        "SUPER,Left,focusdir,left"
        "SUPER,Right,focusdir,right"
        "SUPER,Up,focusdir,up"
        "SUPER,Down,focusdir,down"
        "ALT,o,focusdir,left"
        "ALT,i,focusdir,up"
        "ALT,e,focusdir,down"
        "ALT,u,focusdir,right"

        # Exchange client
        "ALT+SHIFT,Left,exchange_client,left"
        "ALT+SHIFT,Right,exchange_client,right"
        "ALT+SHIFT,Up,exchange_client,up"
        "ALT+SHIFT,Down,exchange_client,down"
        "SUPER+SHIFT,Left,exchange_client,left"
        "SUPER+SHIFT,Right,exchange_client,right"
        "SUPER+SHIFT,Up,exchange_client,up"
        "SUPER+SHIFT,Down,exchange_client,down"

        # Focus stack
        "SUPER+SHIFT,comma,focusstack,prev"
        "SUPER+SHIFT,period,focusstack,next"

        # Layouts
        "SUPER+ALT,space,switch_layout"
        "ALT,t,setlayout,tile"
        "ALT,s,setlayout,scroller"
        "ALT,m,setlayout,monocle"
        "ALT,g,setlayout,grid"
        "ALT,d,setlayout,deck"
        "ALT+SHIFT,t,setlayout,center_tile"
        "ALT+SHIFT,s,setlayout,vertical_scroller"
        "ALT+SHIFT,g,setlayout,vertical_grid"

        # Master adjustments
        "SUPER+SHIFT,equal,incnmaster,+1"
        "SUPER+SHIFT,minus,incnmaster,-1"
        "SUPER+CTRL,equal,setmfact,+0.05"
        "SUPER+CTRL,minus,setmfact,-0.05"

        # Gaps
        "SUPER+CTRL+SHIFT,equal,incgaps,+2"
        "SUPER+CTRL+SHIFT,minus,incgaps,-2"
        "SUPER+CTRL+SHIFT,BackSpace,togglegaps"

        # Scratchpad
        "SUPER,i,minimized"
        "ALT,z,toggle_scratchpad"
        "SUPER+SHIFT,i,restore_minimized"

        # Multi-monitor
        "SUPER,period,focusmon,right"
        "SUPER,comma,focusmon,left"
        "SUPER+SHIFT,period,tagmon,right"
        "SUPER+SHIFT,comma,tagmon,left"

        # Floating window movement
        "SUPER+CTRL,Left,smartmovewin,left"
        "SUPER+CTRL,Right,smartmovewin,right"
        "SUPER+CTRL,Up,smartmovewin,up"
        "SUPER+CTRL,Down,smartmovewin,down"
        "SUPER+ALT,Left,smartresizewin,left"
        "SUPER+ALT,Right,smartresizewin,right"
        "SUPER+ALT,Up,smartresizewin,up"
        "SUPER+ALT,Down,smartresizewin,down"

        # Media controls
        "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 5%+"
        "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 5%-"
        "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SINK@ toggle"
        "SHIFT,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SOURCE@ toggle"
        "NONE,XF86AudioNext,spawn,playerctl next"
        "NONE,XF86AudioPrev,spawn,playerctl previous"
        "NONE,XF86AudioPlay,spawn,playerctl play-pause"
        "NONE,XF86MonBrightnessUp,spawn,brightnessctl s +5%"
        "NONE,XF86MonBrightnessDown,spawn,brightnessctl s 5%-"
        "SHIFT,XF86MonBrightnessUp,spawn,brightnessctl s 100%"
        "SHIFT,XF86MonBrightnessDown,spawn,brightnessctl s 1%"

        # Screenshot
        "NONE,Print,spawn,grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT,Print,spawn,grim - | wl-copy"
        "CTRL,Print,spawn,grim -g \"$(slurp)\" ~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png"

        # System
        "SUPER+CTRL,q,quit"
        "SUPER+SHIFT+CTRL,q,quit"
        "ALT+SHIFT+CTRL,q,quit"
      ];

      # ---- Resize Mode (keymode) ----
      keymode = {
        resize = {
          bind = [
            "NONE,Left,resizewin,-10,0"
            "NONE,Right,resizewin,+10,0"
            "NONE,Up,resizewin,0,-10"
            "NONE,Down,resizewin,0,+10"
            "SHIFT,Left,resizewin,-50,0"
            "SHIFT,Right,resizewin,+50,0"
            "SHIFT,Up,resizewin,0,-50"
            "SHIFT,Down,resizewin,0,+50"
            "NONE,Escape,setkeymode,default"
            "SUPER+SHIFT,r,setkeymode,default"
          ];
        };
      };
    };
  };
}
