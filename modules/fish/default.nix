{
  mkFeature,
  pkgs,
  config,
  ...
}:
mkFeature config {
  name = "fish";

  nixos = {
    programs.fish.enable = true;

    users.users.${config.hostSpecs.username}.shell = pkgs.fish;
  };

  home.programs.fish = {
    enable = true;

    functions = {
      check-flake = ''
        if not test -f flake.nix
          echo "Error: Not inside a Nix flake directory (flake.nix not found)." >&2
          return 1
        end
      '';

      nix-profile-from-tags = ''
        check-flake; or return 1
        git add .
        set -l attr $argv[1]

        set -l profile (
          nix eval --raw \
            ".#nixosConfigurations.$attr.config.system.nixos.tags" \
            --apply 'tags: builtins.concatStringsSep "-" (builtins.sort builtins.lessThan tags)'
        )

        if test -z "$profile"
          echo "No tags found for $attr" >&2
          return 1
        end

        echo $profile
      '';

      nrs = ''
        check-flake; or return 1
        git add .
        set -l attr $argv[1]
        set -l profile (nix-profile-from-tags $attr)
        or return 1

        git add .
        sudo nixos-rebuild switch \
          --flake ".#$attr" \
          --profile-name "$profile"
      '';

      nrb = ''
        check-flake; or return 1
        git add .
        set -l attr $argv[1]
        set -l profile (nix-profile-from-tags $attr)
        or return 1

        sudo nixos-rebuild boot \
          --flake ".#$attr" \
          --profile-name "$profile"
      '';
    };

    shellAliases = {
      ide = "nvim .";
      l = "ls -la";
      nix-shell = "nix-shell --run 'fish'";
      pixi-init = "pixi init --format pyproject";
    };

    shellInit = ''
      if test -S "$XDG_RUNTIME_DIR/ssh-agent"
        set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent"
      end

      pixi completion --shell fish | source
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
