{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "test"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable hyprland
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.uwsm.enable = true;
}
