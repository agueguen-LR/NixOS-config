{
  pkgs,
  outputs,
  inputs,
  ...
}: let
  modules = outputs.homeManagerModules;
in {
  imports = [
    ../common-home.nix
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    modules.catppuccin
    modules.dankMaterial
    modules.direnv
    modules.fish
    modules.fzf
    modules.kitty
    modules.librewolf
    modules.niri
    modules.nixcord
    # modules.nixvim
    modules.nvf
    # modules.noctalia
    modules.yazi
    modules.zoxide
  ];

  programs.niri.settings = {
    binds = let
      # noctalia = cmd:
      #   [
      #     "noctalia-shell"
      #     "ipc"
      #     "call"
      #   ]
      #   ++ (pkgs.lib.splitString " " cmd);
      dms = cmd:
        [
          "dms"
          "ipc"
          "call"
        ]
        ++ (pkgs.lib.splitString " " cmd);
    in {
      "Mod+T".action.spawn = "kitty";
      "Mod+B".action.spawn = "librewolf";
      # "Mod+R".action.spawn = noctalia "launcher toggle";
      # "Mod+S".action.spawn = noctalia "settings toggle";
      "Mod+R".action.spawn = dms "spotlight toggle";
      "Mod+Shift+R".action.spawn = ["sh" "-c" ''dms kill && dms run -d''];
      "Mod+S".action.spawn = dms "settings toggle";
      "Print".action.spawn = ["dms" "screenshot"];
    };
    spawn-at-startup = [
      # {command = ["noctalia-shell"];}
      {command = ["dms" "run" "-d"];}
    ];
  };

  # programs.dankMaterialShell.niri.enableSpawn = true;

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

  home.sessionVariables = {
    DISPLAY = ":0";
  };
}
