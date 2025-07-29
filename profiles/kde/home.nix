{ pkgs, inputs, outputs, lib, ... }:
let
  modules = outputs.homeManagerModules;
in
{
  imports = [
    ../common-home.nix
    inputs.nvf.homeManagerModules.default
    modules.zvm
    modules.tmux
    modules.alacritty
    modules.nvf
    modules.librewolf
    modules.nixcord
  ];

  home.packages = with pkgs; [];
  
  home.activation.createDiscordConfigDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.config/discord
  '';

  home.file = {};

  home.sessionVariables = {};

  programs.zsh.enable = true;
}
