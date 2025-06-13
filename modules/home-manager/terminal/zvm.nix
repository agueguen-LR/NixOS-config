{ pkgs, ... }: {
 
programs.zsh = {
  enableCompletion = true;
  enableAutosuggestions = true;
  enableSyntaxHighlighting = true;      
     
  # Tweak settings for history
  history = {
    save = 1000;
    size = 1000;
    path = "$HOME/.cache/zsh_history";
  };

  # .zshrc
  initContent = ''
    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ];
      then tmux a -t default || exec tmux new -s default && exit;
    fi
  '';
     
  plugins = [
    {
      name = "vi-mode";
      src = pkgs.zsh-vi-mode;
      file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
    }
  ];
 };
 
}
