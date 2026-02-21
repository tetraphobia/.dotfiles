{ config, pkgs, ... }:

{
  home.username = "skip";
  home.homeDirectory = "/home/skip";

  # Packages
  home.packages = with pkgs; [
    nautilus		# File manager
    xterm		# Fallback terminal
  ];

  # Configure Git
  programs.git = {
    enable = true;
    settings.user = {
      name = "Jacob Teddy";
      email = "tetraphobia@wyvrn.dev";
    };
  };

  # Configure bash shell
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$HOME/.dotfiles/bin:$PATH"
    '';
  };

  # Configure firefox
  programs.firefox = {
    enable = true;
    # TODO Set firefox preferences here.
  };

  # Configure kitty
  programs.kitty = {
    enable = true;
  };

  home.stateVersion = "25.11";
}
