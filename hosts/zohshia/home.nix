{ config, pkgs, ... }:

{
  # Hyprland
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, preferred, auto, 1.25"
      "DP-2, preferred, auto, 1.25"
      "DP-3, preferred, auto, 1.25"
    ];
    debug = {
      disable_logs = false;
    };
  };
}
