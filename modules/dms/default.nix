{
  inputs,
  config,
  lib,
  pkgs,
  mkFeature,
  root,
  ...
}:
mkFeature config {
  name = "dms";

  hmImports = [
    inputs.dankMaterialShell.homeModules.default
  ];

  options = {
    compositor = lib.mkOption {
      type = lib.types.str;
      default = "niri";
      description = "Compositor launched by dms";
    };

    wallpaper = lib.mkOption {
      type = lib.types.path;
      default = root + /hosts/workstations/_wallpapers/catppuccin-nixos.png;
      description = "Wallpaper used by DankMaterialShell.";
    };
  };

  nixos = {
    hostSpecs.quickActions = {
      screenshot = lib.mkDefault ["dms" "screenshot"];
      settings = lib.mkDefault ["dms" "ipc" "call" "settings" "toggle"];
      appLauncher = lib.mkDefault ["dms" "ipc" "call" "spotlight" "toggle"];
      restartQuickshell = lib.mkDefault ["sh" "-c" ''dms kill''];
    };

    programs.dms-shell = {
      enable = true;

      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      enableSystemMonitoring = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
      enableClipboardPaste = true;
    };

    services.displayManager.dms-greeter = {
      enable = true;
      package = inputs.dankMaterialShell.packages.${pkgs.stdenv.hostPlatform.system}.default;

      compositor = {
        name = config.features.dms.compositor;

        customConfig = lib.mkIf (config.features.dms.compositor == "niri") ''
          input {
            keyboard {
              xkb {
                layout "${config.hostSpecs.keyboard.layout}"
                options "${config.hostSpecs.keyboard.options}"
              }
              numlock
            }
          }

          hotkey-overlay {
            skip-at-startup
          }
        '';
      };

      configHome = "/home/${config.hostSpecs.username}";

      configFiles = [
        "/home/${config.hostSpecs.username}/.config/DankMaterialShell/settings.json"
      ];

      logs = {
        save = true;
        path = "/tmp/dms-greeter.log";
      };
    };
  };

  home.programs.dank-material-shell = {
    enable = true;

    session = {
      wallpaperPath = config.features.dms.wallpaper;
      weatherLocation = "La Rochelle, 17000";
      weatherCoordinates = "46.1597320,-1.1515951";
    };

    settings = {
      currentThemeName = "custom";
      customThemeFile = ./themes + "/catppuccin.json";
      dynamicTheming = true;

      matugenScheme = "scheme-tonal-spot";
      runUserMatugenTemplates = true;
      matugenTargetMonitor = "";

      fontFamily = "Inter Variable";
      monoFontFamily = "JetBrainsMono NF";

      useAutoLocation = false;
      weatherEnabled = true;

      showBattery = config.hostSpecs.hasBattery;
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
        ++ lib.optional config.hostSpecs.hasBattery "suspend";

      controlCenterShowNetworkIcon = true;
      controlCenterShowBluetoothIcon = true;
      controlCenterShowAudioIcon = true;

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
          screenPreferences = ["all"];
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

          centerWidgets = ["workspaceSwitcher"];

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
            ++ lib.optional config.hostSpecs.hasBattery "battery"
            ++ ["controlCenterButton"];

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
