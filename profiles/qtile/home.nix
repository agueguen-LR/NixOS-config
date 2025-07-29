{ pkgs, inputs, outputs, ... }:
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
  ];

  home.packages = with pkgs; [];

  home.file = {};

  home.sessionVariables = {};

  programs.zsh.enable = true;
}
