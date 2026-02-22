{ config, pkgs, ... }:

{
  # Notification daemon
  services.swaync = {
    enable = true;
    # TODO Configure swaync
  };

  # Qt Wayland Support
  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
    gtk3
    rose-pine-hyprcursor
  ];

  # Hint Electron apps to use Wayland
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Polkit Agent
  # TODO Enable polkit agent

  # Prefer dark mode for GTK apps
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "rose-pine-hyprcursor";
      cursor-size = 24;
    };
  };

  # Enable hyprland
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = null;
  wayland.windowManager.hyprland.portalPackage = null;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "alacritty";
    "$fileManager" = "nautilus";
    "$menu" = "hyprlauncher";

    workspace = [
      "1, default:true"
      "2"
      "3"
      "4"
      "5"
      "6"
    ];

    exec-once = [
      "waybar"
    ];

    env = [
      "HYPRCURSOR_SIZE,24"
      "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      "XCURSOR_THEME,rose-pine-hyprcursor"
      "XCURSOR_SIZE,24"
      "KITTY_DISABLE_WAYLAND,0"
      "XDG_CURRENT_DESKTOP,Hyprland"
    ];

    general = {
      "gaps_in" = 5;
      "gaps_out" = 10;
      "border_size" = 2;

      "col.active_border" = "rgba(f38ba8ff) rgba(fab387ff) rgba(f9e2afff) 45deg";
      "col.inactive_border" = "rgba(31324400)";

      "resize_on_border" = false;
      "allow_tearing" = false;

      "layout" = "master";
    };

    master = {
      "new_status" = "master";
      "allow_small_split" = true;
    };

    misc = {
      "force_default_wallpaper" = 0;
      "disable_hyprland_logo" = true;
    };

    xwayland = {
      "use_nearest_neighbor" = false;
    };

    decoration = {
      "rounding" = 10;
      "rounding_power" = 2;

      blur = {
        "enabled" = true;
        "size" = 3;
        "passes" = 1;
        "vibrancy" = 0.1696;
      };

      shadow = {
        enabled = true;
        range = 20;
        render_power = 3;
        color = "rgba(0, 0, 0, 0.5)";
        offset = "0 5";
      };
    };

    input = {
      "kb_layout" = "us";
      "kb_options" = "caps:ctrl_modifier";
      "follow_mouse" = 1;
      "sensitivity" = 0;
      "accel_profile" = "flat";

      touchpad = {
        "natural_scroll" = true;
      };
    };

    bind = [
      # Applications
      "$mod, Return, exec, $terminal"
      "$mod, E, exec, $fileManager"
      "$mod, Super_L, exec, $menu"

      # Hyprland Management
      "$mod SHIFT, Q, exec, hyprctl dispatch exit"

      # Window Management
      "$mod, Q, killactive,"
      "$mod, P, togglefloating,"
      "$mod, F, fullscreen, 1"
      "$mod, S, layoutmsg, swapwithmaster"
      "$mod, V, togglesplit,"

      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      "$mod CTRL, L, layoutmsg, rollprev"
      "$mod CTRL, H, layoutmsg, rollnext"
      "$mod CTRL, K, layoutmsg, swapprev"
      "$mod CTRL, J, layoutmsg, swapnext"

      "$mod, M, layoutmsg, addmaster"
      "$mod CTRL, M, layoutmsg, removemaster"

      # Navigation
      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"

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

    ];

    bindm = [
      # Mouse Resizing
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    windowrule = [
      "suppressevent maximize, class:.*"
      "nofocus,class:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      "noborder,focus:0"
    ];

    animations = {
      "enabled" = "yes";

      "bezier" = [
        #        NAME,           X0,   Y0,   X1,   Y1
        "easeOutQuint,   0.23, 1,    0.32, 1"
        "easeInOutCubic, 0.65, 0.05, 0.36, 1"
        "linear,         0,    0,    1,    1"
        "almostLinear,   0.5,  0.5,  0.75, 1"
        "quick,          0.15, 0,    0.1,  1"
      ];

      # Default animations, see https://wiki.hypr.land/Configuring/Animations/

      "animation" = [
        #        NAME,          ONOFF, SPEED, CURVE,        [STYLE]
        "global,        1,     10,    default"
        "border,        1,     5.39,  easeOutQuint"
        "windows,       1,     4.79,  easeOutQuint"
        "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
        "windowsOut,    1,     1.49,  linear,       popin 87%"
        "fadeIn,        1,     1.73,  almostLinear"
        "fadeOut,       1,     1.46,  almostLinear"
        "fade,          1,     3.03,  quick"
        "layers,        1,     3.81,  easeOutQuint"
        "layersIn,      1,     4,     easeOutQuint, fade"
        "layersOut,     1,     1.5,   linear,       fade"
        "fadeLayersIn,  1,     1.79,  almostLinear"
        "fadeLayersOut, 1,     1.39,  almostLinear"
        "workspaces,    1,     1.94,  almostLinear, fade"
        "workspacesIn,  1,     1.21,  almostLinear, fade"
        "workspacesOut, 1,     1.94,  almostLinear, fade"
        "zoomFactor,    1,     7,     quick"
      ];
    };

  };
}
