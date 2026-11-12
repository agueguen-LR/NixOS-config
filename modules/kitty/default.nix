{
  mkFeature,
  pkgs,
  lib,
  config,
  ...
}:
mkFeature config {
  name = "kitty";

  nixos = {
    hostSpecs.quickActions.terminal = lib.mkDefault ["kitty"];
  };

  home.programs.kitty = {
    enable = true;
    enableGitIntegration = true;

    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    shellIntegration.enableFishIntegration = true;

    settings.confirm_os_window_close = 0;

    extraConfig = lib.readFile ./OLEDppuccin.conf;
  };
}
