{
  lib,
  config,
  inputs,
  mkFeature,
  ...
}: let
  configFile = lib.readFile ./config.conf;

  monitorRules =
    lib.lists.imap0 (
      i: name: let
        width = builtins.elemAt config.hostSpecs.monitor.width i;
        height = builtins.elemAt config.hostSpecs.monitor.height i;
        xoffset = builtins.elemAt config.hostSpecs.monitor.xoffset i;
        yoffset = builtins.elemAt config.hostSpecs.monitor.yoffset i;
        refreshRate = builtins.elemAt config.hostSpecs.monitor.refreshRate i;
      in "monitorrule=${name},0.55,1,tile,0,1,${toString xoffset},${toString yoffset},${toString width},${toString height},${toString refreshRate}"
    )
    config.hostSpecs.monitor.name;

  monitorRulesString = lib.strings.concatStringsSep "\n" monitorRules;
in
  mkFeature config {
    name = "mango";

    imports = [
      inputs.mango.hmModules.mango
      inputs.mango.nixosModules.mango
    ];

    options.swww.enable =
      lib.mkEnableOption "swww wallpaper integration"
      // {
        default = false;
      };

    nixos.programs.mango.enable = true;

    home.wayland.windowManager.mango = {
      enable = true;

      settings = lib.strings.concatStringsSep "\n" [
        configFile
        monitorRulesString
        "xkb_rules_layout=${config.hostSpecs.keyboard.layout}"
        "xkb_rules_options=${config.hostSpecs.keyboard.options}"
      ];

      autostart_sh = lib.mkIf config.features.mango.swww.enable ''
        swww img "${toString ../../wallpaper/wallpapers/catppuccin-nixos.png}"
      '';
    };
  }
