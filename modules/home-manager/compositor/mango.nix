{...}: let
  config = import ./mango/config.nix;
in {
  wayland.windowManager.mango = {
    enable = true;
    settings = config.config;
    autostart_sh = ''
      # see autostart.sh
      # Note: here no need to add shebang
    '';
  };
}
