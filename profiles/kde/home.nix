{
  pkgs,
  inputs,
  outputs,
  lib,
  ...
}: let
  modules = outputs.homeManagerModules;
in {
  imports = [
    ../common-home.nix
    inputs.nixvim.homeModules.nixvim
    inputs.catppuccin.homeModules.catppuccin
    modules.zsh
    modules.alacritty
    modules.nixvim
    modules.librewolf
    modules.nixcord
  ];

  catppuccin.enable = true;

  home.packages = with pkgs; [];

  home.activation.createDiscordConfigDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/.config/discord
  '';

  home.file = {};

  home.sessionVariables = {};
}
