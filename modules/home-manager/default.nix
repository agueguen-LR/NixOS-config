{
  # List module files here, alphabetically please :)
  # my-module = import ./my-module.nix;
  alacritty = import ./terminal/alacritty.nix;
  direnv = import ./devEnvironments/direnv.nix;
  fish = import ./terminal/fish.nix;
  kitty = import ./terminal/kitty.nix;
  librewolf = import ./browser/librewolf.nix;
  hyprland = import ./compositor/hyprland.nix;
  hyprpaper = import ./wallpaper/hyprpaper.nix;
  hyprcursor = import ./cursor/hyprcursor.nix;
  nixcord = import ./social/nixcord.nix;
  nixvim = import ./nvim/nixvim;
  nvf = import ./nvim/nvf;
  mango = import ./compositor/mango.nix;
  swww = import ./wallpaper/swww.nix;
  tmux = import ./terminal/tmux.nix;
  rofi = import ./appLauncher/rofi.nix;
  waybar = import ./statusBar/waybar.nix;
  yazi = import ./fileManager/yazi.nix;
  zsh = import ./terminal/zsh.nix;
}
