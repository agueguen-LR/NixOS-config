{
  lib,
  config,
  inputs,
  ...
}: let
  configFile = lib.readFile ./config.conf;

  monitorRules =
    lib.lists.imap0 (
      i: name: let
        width = builtins.elemAt config.hostSpec.monitor.width i;
        height = builtins.elemAt config.hostSpec.monitor.height i;
        xoffset = builtins.elemAt config.hostSpec.monitor.xoffset i;
        yoffset = builtins.elemAt config.hostSpec.monitor.yoffset i;
        refreshRate = builtins.elemAt config.hostSpec.monitor.refreshRate i;
      in "monitorrule=${name},0.55,1,tile,0,1,${toString xoffset},${toString yoffset},${toString width},${toString height},${toString refreshRate}"
    )
    config.hostSpec.monitor.name;

  monitorRulesString = lib.strings.concatStringsSep "\n" monitorRules;
in {
  imports = [
    inputs.mango.hmModules.mango
  ];

  wayland.windowManager.mango = {
    enable = true;
    settings = lib.strings.concatStringsSep "\n" [
      configFile
      monitorRulesString
      "xkb_rules_layout=${config.hostSpec.keyboard.layout}"
      "xkb_rules_options=${config.hostSpec.keyboard.options}"
    ];
    autostart_sh = ''
      swww img "${builtins.toString ../../wallpaper/wallpapers/catppuccin-nixos.png}"
    '';
  };
}
