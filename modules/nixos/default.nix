{
  # List module files here
  # my-module = import ./my-module.nix;
  home-manager = import ./home-manager/home-manager.nix;
  firefox = import ./browser/firefox.nix;
  zsh = import ./shell/zsh.nix;
  neovim = import ./editor/neovim.nix;
}
