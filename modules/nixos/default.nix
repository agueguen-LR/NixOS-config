{
  # List module files here
  # my-module = import ./my-module.nix;
  firefox = import ./browser/firefox.nix;
  fish = import ./shell/fish.nix;
  home-manager = import ./home-manager/home-manager.nix;
  hyprland = import ./compositor/hyprland.nix;
  mango = import ./compositor/mango.nix;
  neovim = import ./editor/neovim.nix;
  qtile = import ./tilingWM/qtile.nix;
  steam = import ./gaming/steam.nix;
  tuigreet = import ./greeter/tuigreet.nix;
  zsh = import ./shell/zsh.nix;
}
