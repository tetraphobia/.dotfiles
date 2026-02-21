{ config, pkgs, ... }:

{
  # Enable hyprland
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = null;
  wayland.windowManager.hyprland.portalPackage = null;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "nautilus";
    "$menu" = "~/bin/wofi-launch.sh";

    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
      "KITTY_DISABLE_WAYLAND,0"
      "XDG_CURRENT_DESKTOP,Hyprland"
    ];

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
