{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    debug = {
      disable_logs = false;
    };
  };
}
