{
  inputs,
  config,
  lib,
  mkFeature,
  ...
}:
mkFeature config {
  name = "kde-plasma";

  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  home.programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      # cursor = {
      #   theme = "Bibata-Modern-Ice";
      #   size = 32;
      # };
      # iconTheme = "Papirus-Dark";
      wallpaper = ./. + "../wallpaper/wallpapers/catppuccin-nixos.png";
    };

    hotkeys.commands = {
      "open-terminal" = {
        name = "Open Terminal (kitty)";
        command = "kitty";
        key = "Meta+T";
      };
    };

    input.keyboard = {
      numlockOnStartup = "on";
      options = lib.strings.splitString "," config.hostSpecs.keyboard.options;
      layouts = [
        {
          displayName = "default";
          layout = config.hostSpecs.keyboard.layout;
        }
      ];
    };
  };
}
