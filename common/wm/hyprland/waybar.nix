{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pavucontrol
    blueberry
  ];

  programs.waybar.enable = true;
  programs.waybar.settings.main = {
    reload_style_on_change = true;
    layer = "top";
    position = "top";

    margin-top = 10;
    margin-right = 10;
    margin-left = 10;

    modules-left = [
      "hyprland/workspaces"
      "hyprland/window"
    ];

    modules-center = [
      "clock"
    ];

    modules-right = [
      "group/tray-expander"
      "network"
      "bluetooth"
      "pulseaudio"
      "battery"
    ];

    # Module configs
    "group/tray-expander" = {
      "orientation" = "inherit";
      "drawer" = {
        "transition-duration" = 600;
        "children-class" = "tray-group-item";
      };
      "modules" = [
        "custom/expand-icon"
        "tray"
        "memory"
        "cpu"
      ];
    };

    "custom/expand-icon" = {
      "format" = "<span size='20pt'>󰮫</span>";
      "tooltip" = false;
    };
    "hyprland/workspaces" = {
      "on-click" = "activate";
      "format" = "{icon}";
      "format-icons" = {
        "default" = "";
        "1" = "";
        "2" = "";
        "3" = "";
        "4" = "";
        "5" = "";
        "6" = "";
        "active" = "";
      };
      "persistent-workspaces" = {
        "1" = [ ];
        "2" = [ ];
        "3" = [ ];
        "4" = [ ];
        "5" = [ ];
        "6" = [ ];
      };

    };
    "hyprland/window" = {
      "max-length" = 45;
      "format" = "{}";
      separate-outputs = true;
      rewrite = {
        "" = "Desktop";
      };
    };

    "cpu" = {
      "interval" = 5;
      "format" = "<span size='20pt' rise='-4000'> {icon0}{icon1}{icon2}{icon3}</span>";
      "format-icons" = [
        "▁"
        "▂"
        "▃"
        "▄"
        "▅"
        "▆"
        "▇"
        "█"
      ];
    };

    "pulseaudio" = {
      "format" = "<span size='26pt' rise='-8000'>{icon}</span> {volume}%";
      "on-click" = "pavucontrol";
      "tooltip-format" = "Volume set to {volume}%";
      "scroll-step" = 5;
      "format-muted" = "";
      "format-icons" = {
        "default" = [
          ""
          ""
          ""
        ];
      };
    };
    "memory" = {
      "format" = "<span size='24pt' rise='-6000'></span> {used:0.1f}gb";
      "interval" = 2;
      "on-click" = "$TERMINAL -e btop";
    };

    "network" = {
      "format-icons" = [
        "󰤯"
        "󰤟"
        "󰤢"
        "󰤥"
        "󰤨"
      ];
      "format" = "<span size='24pt' rise='-6000'>{icon}</span> {essid}";
      "format-wifi" = "<span size='24pt' rise='-6000'>{icon}</span> {essid}";
      "format-ethernet" = "<span size='24pt' rise='-6000'>󰀂</span>";
      "format-disconnected" = "<span size='24pt' rise='-6000'>󰤮</span>";
      "tooltip-format-wifi" = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
      "tooltip-format-ethernet" = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
      "tooltip-format-disconnected" = "Disconnected";
      "interval" = 3;
      "spacing" = 1;
      # "on-click" = "";
    };
    "bluetooth" = {
      "format" = "<span size='x-large'></span>";
      "format-disabled" = "<span size='x-large'>󰂲</span>";
      "format-connected" = "<span size='x-large'></span>";
      "tooltip-format" = "Devices connected: {num_connections}";
      "on-click" = "blueberry";
    };
    "battery" = {
      "format" = "<span size='18pt' rise='-3000'>{icon}</span> {capacity}%";
      "format-discharging" = "<span size='18pt' rise='-3000'>{icon}</span> {capacity}%";
      "format-charging" = "<span size='18pt' rise='-3000'>{icon}</span> {capacity}%";
      "format-plugged" = "<span size='18pt' rise='-3000'></span> {capacity}%";
      "format-icons" = {
        "charging" = [
          "󰢜"
          "󰂆"
          "󰂇"
          "󰂈"
          "󰢝"
          "󰂉"
          "󰢞"
          "󰂊"
          "󰂋"
          "󰂅"
        ];
        "default" = [
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
      };
      "format-full" = "󰂅";
      "tooltip-format-discharging" = "{power:>1.0f}W↓ {capacity}%";
      "tooltip-format-charging" = "{power:>1.0f}W↑ {capacity}%";
      "interval" = 5;
      "states" = {
        "warning" = 20;
        "critical" = 10;
      };
    };
  };
  programs.waybar.style = builtins.readFile ./waybar/style.css;
}
