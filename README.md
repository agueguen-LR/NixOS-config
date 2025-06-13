# dotfiles

Dotfiles for my NixOS setup, currently in active development

## NixOS


To build directly for the first time with NixOS minimal install:

> Temporarily install git and flakes through nix-shell
```bash
nix-shell -p git nixFlakes
```

> Clone this repo into /mnt/etc/nixos
```bash
git clone https://github.com/agueguen-LR/dotfiles.git /mnt/etc/nixos
```

> Install with flakes
```bash
nixos-install --flake /mnt/etc/nixos#nixos
```

Rather than building everything directly from install, it's better to build a simple configuration first with only configuration.nix.


Then, add any needed packages to the config (git, vim...) and create a very simple flake so you can store these dotfiles outside of the /etc/nixos directory. 


Rebuild and switch, and now you can clone this repo into your directory of choice (~/.dotfiles for example).

> Run this command to rebuild nixos with these dotfiles.
```bash
sudo nixos-rebuild switch --flake <path-to-dotfiles>#nixos
```
