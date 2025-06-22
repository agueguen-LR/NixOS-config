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
      nrs (){
        sudo nixos-rebuild switch --flake .\#$1 --profile-name $1
      }

      nrb (){
        sudo nixos-rebuild boot --flake .\#$1 --profile-name $1
      }

      ide (){
        if command -v tmux &> /dev/null && command -v nvim &> /dev/null;
          then tmux new-session -d 'nvim .' && tmux split-window && tmux resize-pane -D 10 && tmux a
        else
          echo "tmux or nvim modules are not loaded"
        fi
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
