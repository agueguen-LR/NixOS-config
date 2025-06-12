# dotfiles

Dotfiles for my NixOS setup, currently in active development

## NixOS

Run this command to rebuild nixos with these dotfiles.

I use a hard path to /etc/nixos/hardware-configuration so the --impure is necessary.

```bash
sudo nixos-rebuild switch --flake <path-to-dotfiles>/nixos#nixos --impure
```
