{
  mkFeature,
  config,
  ...
}:
mkFeature config {
  name = "direnv";

  home.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
