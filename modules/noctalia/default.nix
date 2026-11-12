{
  inputs,
  lib,
  config,
  mkFeature,
  root,
  ...
}:
mkFeature config {
  name = "noctalia";

  hmImports = [
    inputs.noctalia.homeModules.default
  ];

  options = {
    compositor = lib.mkOption {
      type = lib.types.str;
      default = "niri";
      description = "Compositor launched by noctalia-greet";
    };
  };

  nixos = {
    system.nixos.tags = ["noctalia"];

    hostSpecs.quickActions = {
      screenshot = lib.mkDefault ["noctalia" "msg" "screenshot-annotate"];
      settings = lib.mkDefault ["noctalia" "msg" "settings-toggle"];
      appLauncher = lib.mkDefault ["noctalia" "msg" "panel-toggle" "launcher"];
    };

    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        session.default = config.features.noctalia.compositor;
        appearance = {
          scheme = "Synced";

          palette = {
            primary = "#CBA6F7";
            on_primary = "#11111B";

            secondary = "#B4BEFE";
            on_secondary = "#000000";

            tertiary = "#94E2D5";
            on_tertiary = "#000000";

            error = "#F38BA8";
            on_error = "#000000";

            surface = "#000000";
            on_surface = "#CDD6F4";

            surface_variant = "#181825";
            on_surface_variant = "#BAC2DE";

            outline = "#585B70";
            shadow = "#000000";

            hover = "#A6E3A1";
            on_hover = "#000000";
          };

          font_family = "JetBrainsMono Nerd Font";

          wallpaper = root + /hosts/workstations/_wallpapers/catppuccin.png;

          hide_logo = true;
        };
        keyboard = {
          layout = config.hostSpecs.keyboard.layout;
          options = config.hostSpecs.keyboard.options;
          numlock = true;
        };
      };
    };

    features.niri.runOnLaunch = lib.mkIf (config.features.dms.compositor == "niri") [
      ["noctalia"]
    ];
  };

  home.programs.noctalia = {
    enable = true;

    systemd.enable = true;

    settings = {
      shell.font_family = "JetBrainsMono Nerd Font";

      bar.default = {
        position = "top";
        margin_ends = 0;
        padding = 4;
        concave_edge_corners = false;
        radius_top_left = 0;
        radius_top_right = 0;
        color = "primary";

        start = [
          "control-center"
          "launcher"
          "media"
          "audio-vis"
        ];

        center = [
          "workspaces"
        ];

        end =
          [
            "tray"
            "wallpaper"
            "clock"
            "weather"
            "clipboard"
            "notifications"
            "bluetooth"
            "network"
            "volume"
            "brightness"
          ]
          ++ lib.optional config.hostSpecs.hasBattery "battery"
          ++ [
            "session"
          ];
      };

      widget = {
        clock = {
          format = "{:%H:%M} {:%a %d-%m-%y}";
          vertical_format = "{:%H\\n%M}";
          tooltip_format = "{:%A, %B %d, %Y}";
          timezone = "";
        };

        session.color = "tertiary";

        network.show_label = false;

        weather.show_condition = false;

        audio-vis = {
          type = "audio_visualizer";
          width = 64;
          bands = 20;
          centered = true;
          actions.left = "exec noctalia msg panel-toggle control-center media";
        };
      };

      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = root + /hosts/workstations/_wallpapers;
        default.path = root + /hosts/workstations/_wallpapers/catppuccin.png;
      };

      theme = {
        source = "community";
        community_palette = "Catppuccin Mocha Blue";
        pure_black_dark = true;
      };

      location.address = "La Rochelle, France";
    };
  };
}
