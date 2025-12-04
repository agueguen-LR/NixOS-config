{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;

    functions = {
      nrs = "
        git add .
        sudo nixos-rebuild switch --flake .\#$argv[1] --profile-name $argv[1]
				";

      nrb = "
        git add .
        sudo nixos-rebuild boot --flake .\#$argv[1] --profile-name $argv[1]
      ";
    };

    shellAliases = {
      ide = "nvim .";
      l = "ls -l";
      nix-shell = "nix-shell --run 'fish'";
    };

    shellInit = ''
      if test -S "$XDG_RUNTIME_DIR/ssh-agent"
        set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent"
      end
    '';

    plugins = [
      {
        name = "pure";
        src = pkgs.fetchFromGitHub {
          owner = "pure-fish";
          repo = "pure";
          rev = "a3261c9f8bb4d25a45b700efb3e6d8e7039a0ce8";
          sha256 = "mMUFR/n4aLsmZNbVAYmx57AMXT6U2P+wTuuN3opCeqs=";
        };
      }
    ];
  };
}
