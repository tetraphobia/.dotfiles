{
  config,
  pkgs,
  inputs,
  ...
}:

{

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprlauncher -d"
    ];
  };
  home.packages = [
    inputs.hyprlauncher.packages.${pkgs.stdenv.hostPlatform.system}.hyprlauncher
  ];
}
