{ config, pkgs, ... }:
{
  services.swaync = {
    enable = true;
  };

  xdg.configFile = {
    "swaync/style.css".source = ./swaync/style.css;
  };

}
