{ pkgs, inputs, outputs, ... }:
let
  modules = outputs.homeManagerModules;
in
{
  imports = [
    ../common-home.nix
		inputs.nixvim.homeModules.nixvim
    inputs.catppuccin.homeModules.catppuccin
    modules.zsh
		modules.nixvim
    modules.alacritty
    modules.librewolf
  ];

  home.packages = with pkgs; [];

  home.file = {};

  home.sessionVariables = {};
}
