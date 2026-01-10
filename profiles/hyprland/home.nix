{
  pkgs,
  outputs,
  ...
}: let
  modules = outputs.homeManagerModules;
in {
  imports = [
    ../common-home.nix
    modules.catppuccin
    modules.dankMaterial
    modules.direnv
    modules.fish
    modules.fzf
    modules.kitty
    modules.librewolf
    modules.nixcord
    modules.nixvim
    modules.hyprcursor
    modules.hyprland
    modules.hyprpaper
    # modules.rofi
    # modules.waybar
    modules.yazi
    modules.zoxide
  ];

  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, T, exec, kitty"
    "SUPER, B, exec, librewolf"
    # "SUPER+R".action.spawn = noctalia "launcher toggle";
    # "SUPER+S".action.spawn = noctalia "settings toggle";
    "SUPER, R, exec, dms ipc call spotlight toggle"
    "SUPER SHIFT, R, exec, dms kill && dms run -d"
    "SUPER, S, exec, dms ipc call settings toggle"
    ", Print, exec, dms screenshot"
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableFishIntegration = true;
    extraConfig = ''
      allow-loopback-pinentry
    '';
    pinentry = {
      package = pkgs.pinentry-rofi;
      program = "pinentry-rofi";
    };
  };
}
