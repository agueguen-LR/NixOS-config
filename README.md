# NixOS-config

Dotfiles for my NixOS setup, currently there are three available configurations, each accessible through a different nix flake.


The default flake, is equivalent to a completely bare installation with only git, vim and home-manager. There is no desktop environnement or wayland compositor.
```bash
sudo nixos-rebuild switch --flake .#default
```


The qtile flake comes with the X11 window manager [qtile](https://qtile.org/), a basic [nvf](https://github.com/NotAShelf/nvf) neovim configuration, the [librewolf](https://librewolf.net/) browser and a couple frills. A good simple config to use to start developping new modules for a larger configuration.
```bash
sudo nixos-rebuild switch --flake .#qtile
```


The hyprland flake comes with the wayland compositor [hyprland](https://hypr.land/) and many more apps and frills, it is currently in active development.
```bash
sudo nixos-rebuild switch --flake .#hyprland
```

## Disko Install, with zfs impermanence

!!! WARNING !!!
Disko-install seems to use extreme amounts of RAM, 6G wasn't enough to make it work in a qemu vm, so this is not fully tested, proceed at your own risk.

To install this configuration on a new system with disko-install and zfs impermanence, use the NixOS minimal installer and connect to the internet.

Then simply run this command, replacing disk-name and device-name (disk-name can be anything but device-name should be /dev/something, use ``` lsblk ``` to choose the device):
```bash
sudo nix --experimental-features 'nix-command flakes' run \
    'github:nix-community/disko/latest#disko-install' -- --flake \
    'github:agueguen-LR/NixOS-config#default-install' --disk <disk-name> <device-name>
```

After, boot into the system and rebuild and switch to your config of choice.

## Custom Install

After installation on NixOS, build a [simple flake](https://github.com/Misterio77/nix-starter-configs/tree/main/minimal) so you can store these config files outside of /etc/nixos


Clone this repo into your directory of choice, like ~/.dotfiles/ and make sure to replace ./hardware-configuration.nix with your own:
```bash
sudo cp /etc/nixos/hardware-configuration.nix <path-to-dotfiles>/hardware-configuration.nix
```


Then rebuild and switch to the desired flake
```bash
sudo nixos-rebuild switch --flake <path-to-dotfiles>#<flake-name>
```

## Modules

All external applications should have their own .nix config file within the modules directory. I admit I haven't been careful to avoid dependencies between modules but all module config files are small so check their contents before importing.


If you have noticed a bad dependency between modules, you can always create your own, or create an issue on this repository if you notice anything particularly bad within my code.
