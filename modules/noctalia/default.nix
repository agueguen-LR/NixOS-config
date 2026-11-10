{
  inputs,
  pkgs,
  lib,
  config,
  mkFeature,
  ...
}:
mkFeature config {
  name = "noctalia";

  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.programs.noctalia-shell = {
    enable = true;

    settings = {
      bar = {
        density = "mini";
        showCapsule = false;

        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
          ];

          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];

          right =
            [
              {
                id = "Volume";
                displayMode = "alwaysShow";
              }
            ]
            ++ lib.optional config.hostSpecs.hasBattery {
              id = "CustomButton";
              icon = "battery-4";
              leftClickExec = "noctalia-shell ipc call powerProfile cycle";
              textCommand = "${pkgs.acpi}/bin/acpi -b | grep -Eo '[0-9]+%'";
              textIntervalMs = 3000;
            }
            ++ [
              {
                formatHorizontal = "HH:mm dd.MM.yyyy";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
              {
                id = "SessionMenu";
              }
            ];
        };
      };

      ui = {
        fontDefault = "JetBrainsMono Nerd Font";
        fontFixed = "JetBrainsMono Nerd Font";
      };

      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = ./. + "/../wallpaper/wallpapers";
        randomEnabled = true;
      };

      colorSchemes.predefinedScheme = "Catppuccin";

      dock = {
        enabled = false;
      };

      general.radiusRatio = 0.2;

      location = {
        monthBeforeDay = true;
        name = "La Rochelle, France";
      };
    };
  };
}
