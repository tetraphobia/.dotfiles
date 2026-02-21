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
  ];

  # Polkit Agent
  # TODO Enable polkit agent

  # Statusbar
  programs.waybar.enable = true;
  programs.waybar.settings.main = {
    layer = "top";
    position = "top";
    height = 36;
    spacing = 10;
    modules-left = ["hyprland/workspaces" ];
    modules-center = ["clock"];
    # TODO Bluetooth menu
    modules-right = ["tray"];
  };

  # Launcher
  programs.wofi.enable = true;
  # TODO Configure wofi


  # Enable hyprland
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = null;
  wayland.windowManager.hyprland.portalPackage = null;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "xterm";
    "$fileManager" = "nautilus";
    "$menu" = "~/bin/wofi-launch.sh";

    exec-once = [
      "waybar"
      "xterm"
      "swaync"
    ];

    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
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
      "$mod, F, fullscreen, 1,"
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
  };
}
