{ pkgs, inputs, outputs, lib, ... }:
let
  modules = outputs.homeManagerModules;
in
{
  imports = [
    ../common-home.nix
    inputs.nvf.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
    modules.fish
    modules.kitty
    modules.nvf
    modules.librewolf
    modules.hyprland
    modules.hyprpaper
    modules.hyprcursor
    modules.waybar
    modules.nixcord
  ];

  catppuccin.enable = true;

  home.packages = with pkgs; [];
  
  home.activation.createDiscordConfigDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.config/discord
  '';

  home.file = {};

  home.sessionVariables = {};
}
