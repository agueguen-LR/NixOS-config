{
  pkgs,
  outputs,
  lib,
  ...
}: let
  modules = outputs.homeManagerModules;
in {
  imports = [
    ../common-home.nix
    modules.catppuccin
    modules.direnv
    modules.fish
    modules.fzf
    modules.kitty
    modules.librewolf
    modules.nixcord
    modules.nixvim
    modules.mango
    modules.swww
    modules.rofi
    modules.waybar
    modules.yazi
    modules.zoxide
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

  home.activation.createDiscordConfigDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/.config/discord
  '';
}
