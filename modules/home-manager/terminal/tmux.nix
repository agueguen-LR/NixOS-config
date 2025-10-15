{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";

    plugins = [
      {
        plugin = pkgs.tmuxPlugins.battery;
        extraConfig = ''
          set -g status-right '󰁹 #{battery_percentage} | %H:%M %d/%m/%y'
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.catppuccin;
        extraConfig = ''
               # Options to make tmux more pleasant
                 set -g mouse on
                 set -g default-terminal "tmux-256color"

                 # Configure the catppuccin plugin
                 set -g @catppuccin_flavor "mocha"
                 set -g @catppuccin_window_status_style "rounded"

          set -g status-right-length 100
                 set -g status-left-length 100

        '';
      }
    ];
    terminal = "screen-256color";
    extraConfig = ''
      set -g status-left ""
    '';
  };
}
