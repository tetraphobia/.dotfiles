{ config, pkgs, inputs, ... }:
{
  home.packages = [
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
  ];

  # Run it in Hyprland
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "awww-daemon"
      "random_wallpaper.sh"
    ];
  };
}
