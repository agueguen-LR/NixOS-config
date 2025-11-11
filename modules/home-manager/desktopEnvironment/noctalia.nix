{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here; defaults will
      # be deep merged with these attributes.
      bar = {
        density = "mini";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "SidePanelToggle";
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
          right = [
            {
              id = "Volume";
              displayMode = "alwaysShow";
            }
            {
              id = "CustomButton";
              icon = "battery-4";
              leftClickExec = "noctalia-shell ipc call powerProfile cycle";
              textCommand = "${pkgs.acpi}/bin/acpi -b | grep -Eo '[0-9]+%'";
              textIntervalMs = 3000;
            }
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
        defaultWallpaper = ./. + "/../wallpaper/wallpapers/catppuccin-nixos.png";
      };

      colorSchemes.predefinedScheme = "Catppuccin";

      dock = {
        enabled = true;
        displayMode = "auto_hide";
      };

      general = {
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "La Rochelle, France";
      };
    };
    # this may also be a string or a path to a JSON file,
    # but in this case must include *all* settings.
  };
}
