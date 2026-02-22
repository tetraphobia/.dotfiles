{ config, pkgs, ... }:

{
  home.username = "skip";
  home.homeDirectory = "/home/skip";

  # Packages
  home.packages = with pkgs; [
    nautilus		    # File manager
    xterm		        # Fallback terminal
    discord             # VoIP
    telegram-desktop    # IM

    # Neovim dependencies
    gcc                 # Neovim dependency
    fd
    ripgrep
  ];

  # Configure Git
  programs.git = {
    # TODO Configure git
    enable = true;
    settings.user = {
      name = "Jacob Teddy";
      email = "tetraphobia@wyvrn.dev";
    };
  };

  # Configure bash shell
  programs.bash = {
    # TODO Configure bash shell
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$HOME/.dotfiles/scripts:$PATH"
    '';
  };

  # Configure firefox
  programs.firefox = {
    enable = true;
    # TODO Set firefox preferences here.
  };


  # Configure alacritty
  programs.alacritty = {
    enable = true;
    theme = "catppuccin_mocha";
    settings = {
      general.live_config_reload = true;
      window = {
        padding = {
	  x = 10;
	  y = 10;
	};
	decorations = "none";
      };
      font = {
        normal.family = "Hack Nerd Font Mono";
	size = 11;
      };
    };
  };

  # Fallback terminal for Hyprland
  programs.kitty = {
    enable = true;
  };

  home.stateVersion = "25.11";
}
