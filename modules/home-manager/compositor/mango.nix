{
  lib,
  config,
  ...
}: let
  configFile = lib.readFile ./mango/config.conf;
  monitorRules =
    lib.lists.imap0 (
      i: name: let
        width = builtins.elemAt config.hostSpec.monitor.width i;
        height = builtins.elemAt config.hostSpec.monitor.height i;
        xoffset = builtins.elemAt config.hostSpec.monitor.xoffset i;
        yoffset = builtins.elemAt config.hostSpec.monitor.yoffset i;
        refreshRate = builtins.elemAt config.hostSpec.monitor.refreshRate i;
      in "monitorrule=${name},0.55,1,tile,0,1,${xoffset},${yoffset},${width},${height},${refreshRate}"
    )
    config.hostSpec.monitor.name;
  monitorRulesString = lib.strings.concatStringsSep "\n" monitorRules;
in {
  wayland.windowManager.mango = {
    enable = true;
    settings = lib.strings.concatStringsSep "\n" [
      configFile
      monitorRulesString
    ];
    autostart_sh = ''
      swww img "${builtins.toString ../wallpaper/catppuccin-nixos.png}"
    '';
  };
}
