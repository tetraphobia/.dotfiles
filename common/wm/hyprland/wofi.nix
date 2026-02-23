{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    wofi
  ];

  xdg.configFile = {
    "wofi/config".source = ./wofi/config;
    "wofi/style.css".source = ./wofi/style.css;
  };
}
