{
  pkgs,
  outputs,
  lib,
  config,
  ...
}: let
  modules = outputs.homeManagerModules;
in {
  imports = [
    ../common-home.nix
    modules.catppuccin
    modules.direnv
    modules.fish
    modules.fzf
    modules.kitty
    modules.librewolf
    modules.niri
    modules.nixcord
    modules.nixvim
    modules.noctalia
    modules.yazi
    modules.zoxide
  ];

  programs.niri.settings = {
    binds = let
      noctalia = cmd:
        [
          "noctalia-shell"
          "ipc"
          "call"
        ]
        ++ (pkgs.lib.splitString " " cmd);
    in {
      "Mod+T".action.spawn = "kitty";
      "Mod+B".action.spawn = "librewolf";
      "Mod+R".action.spawn = noctalia "launcher toggle";
      "Mod+S".action.spawn = noctalia "settings toggle";
    };
    spawn-at-startup = [
      {command = ["noctalia-shell"];}
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableFishIntegration = true;
    extraConfig = ''
      allow-loopback-pinentry
    '';
    pinentry = {
      package = pkgs.pinentry-rofi;
      program = "pinentry-rofi";
    };
  };

  home.activation.createDiscordConfigDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/.config/discord
  '';

  home.sessionVariables = {
    DISPLAY = ":0";
  };
}
