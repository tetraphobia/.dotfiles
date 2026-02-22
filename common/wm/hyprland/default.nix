{ config, pkgs, ...}:

{
    imports = [
    ./awww.nix
    ./hyprland.nix
    ./waybar.nix
    ./hyprlauncher.nix
    ];
}
