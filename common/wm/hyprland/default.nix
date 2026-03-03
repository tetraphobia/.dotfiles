{ config, pkgs, ... }:

{
  imports = [
    ./awww.nix
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
    ./swaync.nix
  ];
}
