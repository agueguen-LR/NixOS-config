{
  # List module files here
  # my-module = import ./my-module.nix;
  catppuccin = import ./style/catppuccin.nix;
  firefox = import ./browser/firefox.nix;
  fish = import ./shell/fish.nix;
  home-manager = import ./home-manager/home-manager.nix;
  hyprland = import ./compositor/hyprland.nix;
  mango = import ./compositor/mango.nix;
  neovim = import ./editor/neovim.nix;
  niri = import ./compositor/niri.nix;
  postgresql = import ./database/postgreSQL.nix;
  qtile = import ./tilingWM/qtile.nix;
  steam = import ./gaming/steam.nix;
  stylix = import ./style/stylix.nix;
  tuigreet = import ./greeter/tuigreet.nix;
  virt-manager = import ./virtualisation/virt-manager.nix;
  zsh = import ./shell/zsh.nix;
}
