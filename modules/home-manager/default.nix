{
  # List module files here
  # my-module = import ./my-module.nix;
  zvm = import ./terminal/zvm.nix;
  tmux = import ./terminal/tmux.nix;
  alacritty = import ./terminal/alacritty.nix;
  nvf = import ./nvim/nvf.nix;
}
