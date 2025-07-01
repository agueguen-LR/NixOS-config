{ lib, ... }:
{
  programs.waybar = {
    enable = true;

    systemd.enable = true;
    style = lib.readFile ./waybarStyle/catppuccin-mocha.css;

    settings = {
      mainbar = {
        layer = "top";
        position = "top";

        modules-left = [];
        modules-center = [];
        modules-right = [
          "pulseaudio"
          "battery"
          "clock"
        ];

        "clock" = {
          timezone = "Europe/Paris";
          format = "{:%H:%M %d-%m-%Y}";
        };

        "pulseaudio" = {
          scroll-step = 1;
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-source = "{volume}%  ";
          format-source-muted = " ";
          format-icons = {
              headphone = " ";
              default = [" " " " " "];
          };
          on-click = "pavucontrol";
        };

        "battery" = {
          format = "{capacity}% {icon}";
          format-icons = [" " " " " " " " " "];
        };

      };
    };
  };
}
