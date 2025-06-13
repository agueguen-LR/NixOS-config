{ pkgs, ... }:
let
  catppuccinTmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "main";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "main";
      sha256 = "sha256-poG3QCow2j6h/G7BLEA8v3ZJXuk28iPmH1J4t7vT55k=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    extraConfig = ''
      set -g @catppuccin_flavour 'mocha'
      set -g @catppuccin_window_status_style "rounded"
      run-shell "${catppuccinTmux}/share/tmux-plugins/catppuccin/catppuccin.tmux"
      
      # Make the status line pretty and add some modules
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      #set -agF status-right "#{E:@catppuccin_status_cpu}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"
      #set -agF status-right "#{E:@catppuccin_status_battery}"
    '';
    escapeTime = 0;
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      catppuccinTmux
    ];
    terminal = "screen-256color"; 
  };
}
