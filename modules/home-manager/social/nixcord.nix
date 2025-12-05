{inputs, lib, ...}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

	# for impermanence, make sure config folder exists
  home.activation.createDiscordConfigDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ~/.config/discord
  '';

  programs.nixcord = {
    enable = true;
    vesktop.enable = true;

    config = {
      themeLinks = [
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css"
      ];
      plugins = {
        fakeNitro.enable = true;
      };
    };
  };
}
