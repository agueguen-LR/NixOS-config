# NixOS-config

Dotfiles for my NixOS setup, currently there are three available configurations, each accessible through a different nix flake.


The default flake, is equivalent to a completely bare installation with only git and vim. There is no desktop environment or wayland compositor.
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

## Impermanence

These configurations are built around a system with [ZFS impermanence](https://grahamc.com/blog/erase-your-darlings), as such, the root directory is reset at every reboot and only the files in the /persist directory are kept.


The filesystems are handled by [disko](https://github.com/nix-community/disko).

## Installation 

Boot into the [NixOS minimal installer](https://nixos.org/download/) and connect to the internet.


Clone this repository
```bash
git clone https://github.com/agueguen-LR/NixOS-config
cd NixOS-config
```

Choose the device you want to install to with ```lsblk``` and replace the device name in disko/impermanence.nix with it 
```bash
nano disko/impermanence.nix
```

Run disko
```bash
sudo nix --experimental-features 'nix-command flakes' \
    run github:nix-community/disko/latest -- \
    --mode destroy,format,mount ./disko/impermanence.nix
```

Create your hardware-configuration.nix
```bash
sudo nixos-generate-config --no-filesystems --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix .
```

Move this repo to /mnt/etc/nixos
```bash
sudo mv ./* /mnt/etc/nixos
cd /mnt/etc/nixos
```

Create your password and TEMPORARILY put it into your chosen config by adding hashedPassword = <your-hashed-password> to users.users.<username>
> hashedPasswordFile overwrites hashedPassword so comment it out temporarily
```bash
mkpasswd <your-password> >> configs/<your-chosen-config>/configuration.nix #appends to end of file for copy-pasting
sudo nano configs/<your-chosen-config>/configuration.nix
```
```nix
users.users.<username> = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
    hashedPassword = <your-hashed-password>; 
    #hashedPasswordFile = ...;
};
```

Install your configuration and reboot
```bash
sudo nixos-install --flake .#<your-chosen-config>
reboot
```

Replace your hashedPassword with an agenix encrypted secret
```bash
cd /etc/nixos/secrets
mkpasswd <your-password> #copy this to paste in agenix -e
agenix -e user-password.age -i <path-to-your-ssh-identity>
cd ..
vim configs/<your-chosen-config>/configuration.nix
```
```vim
  age = {
    identityPaths = [ "<path-to-your-ssh-identity>" ];
    secrets.user-password.file = ../../secrets/user-password.age;
  };
```

Following steps can be version-controlling your configuration and moving your configuration into a .dotfiles directory out of /etc/nixos

## Disko-Install

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
