{ config, pkgs, ... }:

{
  # Enable hyprland
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [
      ""
    ];
  };
}
