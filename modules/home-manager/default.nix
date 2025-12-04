{
  # List module files here, alphabetically please :)
  # my-module = import ./my-module.nix;
  alacritty = import ./terminal/terminal-emulator/alacritty.nix;
  catppuccin = import ./style/catppuccin.nix;
  direnv = import ./devEnvironments/direnv.nix;
  fish = import ./terminal/shell/fish.nix;
  fuzzel = import ./appLauncher/fuzzel.nix;
  fzf = import ./terminal/utilities/fzf.nix;
  kitty = import ./terminal/terminal-emulator/kitty.nix;
  librewolf = import ./browser/librewolf.nix;
  hyprland = import ./compositor/hyprland;
  hyprpaper = import ./wallpaper/hyprpaper.nix;
  hyprcursor = import ./cursor/hyprcursor.nix;
  niri = import ./compositor/niri;
  nixcord = import ./social/nixcord.nix;
  nixvim = import ./nvim/nixvim;
  noctalia = import ./quickshell/noctalia.nix;
  nvf = import ./nvim/nvf;
  mango = import ./compositor/mango;
  plasma = import ./desktopEnvironment/plasma.nix;
  stylix = import ./style/stylix.nix;
  swww = import ./wallpaper/swww.nix;
  tmux = import ./terminal/utilities/tmux.nix;
  rofi = import ./appLauncher/rofi.nix;
  waybar = import ./statusBar/waybar.nix;
  yazi = import ./fileManager/yazi.nix;
  zoxide = import ./terminal/utilities/zoxide.nix;
  zsh = import ./terminal/shell/zsh.nix;
}
