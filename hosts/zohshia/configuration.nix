{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zohshia"; # Define your hostname.

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable hyprland
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.uwsm.enable = true;
}
