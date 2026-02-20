{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Required for home-manager
  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.skip = {
    isNormalUser = true;
    description = "skip";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "dialout"];
  };

  # Required to execute dynamically linked binaries.
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
    ];
  };

  # Default to neovim for most things
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };



  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11"; # Did you read the comment?

}
