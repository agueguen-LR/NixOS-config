{ pkgs, ... }:
{
  home.pointerCursor = {
    name = "Catppuccin Mocha Dark";
    package = pkgs.catppuccin-cursors.mochaDark;
    hyprcursor = {
      enable = true;
      size = 20;
    };
  };
}
