{ pkgs, inputs, outputs, lib, ... }:
let
  modules = outputs.homeManagerModules;
in
{
  imports = [
    ../common-home.nix
    inputs.nixvim.homeModules.nixvim
    inputs.catppuccin.homeModules.catppuccin
    modules.fish
    modules.kitty
    modules.nixvim
    modules.librewolf
    modules.hyprland
    modules.hyprpaper
    modules.hyprcursor
    modules.waybar
    modules.nixcord
		modules.yazi
  ];

  catppuccin.enable = true;

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

  home.packages = with pkgs; [];
  
  home.activation.createDiscordConfigDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.config/discord
  '';

  home.file = {};

  home.sessionVariables = {};
}
