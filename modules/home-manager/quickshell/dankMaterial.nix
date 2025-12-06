{
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];

  programs.dankMaterialShell = {
    enable = true;

    default.session = {
      wallpaperPath = ./.. + "/wallpaper/wallpapers/catppuccin-nixos.png";
    };

    # These settings are only applied if ~/.config/DankMaterialShell doesn't exist
    # A nixos-rebuild switch will therefore not apply these, unless you delete that file beforehand
    default.settings = {
      currentThemeName = "cat-blue"; # doesn't work for some reason ???
      customThemeFile = "";

      matugenScheme = "scheme-tonal-spot";
      runUserMatugenTemplates = true;
      matugenTargetMonitor = "";

      fontFamily = "Inter Variable"; # default
      monoFontFamily = "JetBrainsMono NF";

      weatherLocation = "La Rochelle, 17000";
      weatherCoordinates = "46.1597320,-1.1515951";
      useAutoLocation = false;
      weatherEnabled = true;

      showBattery = config.hostSpec.hasBattery;
      clockDateFormat = "ddd dd-MM-yy";
      launcherLogoMode = "os";
      launcherLogoColorOverride = "primary";

      powerMenuDefaultAction = "poweroff";
      powerMenuActions =
        [
          "reboot"
          "poweroff"
          "lock"
          "logout"
          "restart"
        ]
        ++ lib.optional config.hostSpec.hasBattery "suspend";

      controlCenterShowNetworkIcon = true;
      controlCenterShowBluetoothIcon = true;
      controlCenterShowAudioIcon = true;
      controlCenterShowBatteryIcon = config.hostSpec.hasBattery;
      controlCenterWidgets = [
        {
          id = "volumeSlider";
          enabled = true;
          width = 100;
        }
        {
          id = "wifi";
          enabled = true;
          width = 50;
        }
        {
          id = "bluetooth";
          enabled = true;
          width = 50;
        }
        {
          id = "audioOutput";
          enabled = true;
          width = 50;
        }
        {
          id = "audioInput";
          enabled = true;
          width = 50;
        }
        {
          id = "nightMode";
          enabled = true;
          width = 50;
        }
        {
          id = "darkMode";
          enabled = true;
          width = 50;
        }
      ];

      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [
            "all"
          ];
          showOnLastDisplay = true;
          innerPadding = -5;
          leftWidgets = [
            {
              id = "launcherButton";
              enabled = true;
            }
            "cpuUsage"
            "memUsage"
            {
              id = "music";
              enabled = true;
              mediaSize = 0;
            }
          ];
          centerWidgets = [
            "workspaceSwitcher"
          ];
          rightWidgets =
            [
              {
                id = "systemTray";
                enabled = true;
              }
              "clock"
              "weather"
              "colorPicker"
              "clipboard"
              "notificationButton"
            ]
            ++ lib.optional config.hostSpec.hasBattery "battery"
            ++ [
              "controlCenterButton"
            ];
          spacing = 4;
          bottomGap = 0;
          transparency = 1;
          widgetTransparency = 1;
          squareCorners = false;
          noBackground = false;
          gothCornersEnabled = false;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;
          borderEnabled = false;
          borderColor = "surfaceText";
          borderOpacity = 1;
          borderThickness = 1;
          widgetOutlineEnabled = false;
          widgetOutlineColor = "primary";
          widgetOutlineOpacity = 1;
          widgetOutlineThickness = 1;
          fontScale = 1;
          autoHide = false;
          autoHideDelay = 250;
          openOnOverview = false;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
          maximizeDetection = true;
        }
      ];
    };
  };
}
