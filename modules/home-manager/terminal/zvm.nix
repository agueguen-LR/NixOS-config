{ pkgs, ... }: 
{ 
  programs.zsh = {
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;      
       
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

      nrs (){
        cd ~/.dotfiles 
        git add . 
        sudo nixos-rebuild switch --flake .$1
      }
    '';
       
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      theme = "gnzh";
    };

  };
}
