# NixOS-config

Dotfiles for my NixOS setup, currently there are three available configurations, each accessible through a different nix flake.


The default flake, is equivalent to a completely bare installation with only git and vim. There is no desktop environment or wayland compositor.
```bash
sudo nixos-rebuild switch --flake .#default
```


The qtile flake comes with the X11 window manager [Qtile](https://qtile.org/).
```bash
sudo nixos-rebuild switch --flake .#qtile
```


The hyprland flake comes with the wayland compositor [Hyprland](https://hypr.land/).
```bash
sudo nixos-rebuild switch --flake .#hyprland
```


The mango flake comes with the wayland compositor [MangoWC](https://github.com/DreamMaoMao/mangowc).
```bash
sudo nixos-rebuild switch --flake .#mango
```


The kde flake comes with the desktop environment [KDE Plasma 6](https://kde.org/plasma-desktop/).
```bash
sudo nixos-rebuild switch --flake .#kde
```


## Impermanence

These configurations are built around a system with [ZFS impermanence](https://grahamc.com/blog/erase-your-darlings), as such, the root directory is reset at every reboot and only the files in the /persist directory or managed by the [impermanence module](https://github.com/nix-community/impermanence) are kept.


The filesystems are handled by [disko](https://github.com/nix-community/disko).

## Installation 

Boot into the [NixOS minimal installer](https://nixos.org/download/) and [connect to the internet with wpa](https://wiki.archlinux.org/title/Wpa_supplicant#Connecting_with_wpa_cli).


Clone this repository
```bash
git clone https://github.com/agueguen-LR/NixOS-config
cd NixOS-config
```

Copy a template from one of the disko configs in disko/ and modify it to your needs.
Choose the device you want to install to with ```lsblk``` and replace the device name with it 
```bash
cp disko/pc-disko.nix disko/<your-host>-disko.nix
nano disko/impermanence.nix
```

Run disko
```bash
sudo nix --experimental-features 'nix-command flakes' \
    run github:nix-community/disko/latest -- \
    --mode destroy,format,mount ./disko/<your-host>-disko.nix
```

Create your hardware-configuration.nix
```bash
sudo nixos-generate-config --no-filesystems --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix ./hardware/<your-host>-hardware.nix
```

Copy a template from hosts/ and modify it to your needs, adding your hashed password to initialHashedPassword
!! Also set your hostId to the first 8 characters of your machine-id found in /etc/machine-id if you're using ZFS !!
```bash
cp hosts/pc.nix hosts/<your-host>.nix

#appends to end of <your-host.nix>, then copy-paste to users.users.${hostSpecs.username}.initialHashedPassword
mkpasswd <your-password> >> hosts/<your-host>.nix
#appends to end of <your-host.nix>, then copy-paste to networking.hostId
head -c 8 /etc/machine-id >> hosts/<your-host>.nix

nano hosts/<your-host>.nix
```

Edit flake.nix to set your desired nixosConfigurations
> !!! You should remove the others to avoid building them, as that could break things by loading wrong hardware configs, or break ZFS by loading the wrong hostId. 
```bash
nano flake.nix
```
```nix
nixosConfigurations = {
  <your-host>-kde = mkHost "<your-host>.nix" "kde/configuration.nix";
  <your-host>-<other-profile> = mkHost "<your-host>.nix" "<other-profile>/configuration.nix";
  # ...
};
```

Move this repo to /mnt/etc/nixos
```bash
sudo mv ./* /mnt/etc/nixos
cd /mnt/etc/nixos
```

Install your configuration and reboot
```bash
sudo nixos-install --flake .#<your-chosen-config>
reboot
```

Replace your hashedPassword with an agenix encrypted secret if you wish to version control your config with git
```bash
cd /etc/nixos/secrets
mkpasswd <your-password> #copy this to paste in agenix -e
agenix -e user-password.age -i <path-to-your-ssh-identity>
cd ..
vim hosts/<your-host>.nix
```
```nix
age = {
identityPaths = [ "<path-to-your-ssh-identity>" ];
secrets.user-password.file = ../secrets/user-password.age;
};
users.users.${hostSpecs.username}.hashedPasswordFile = config.age.secrets.user-password.path;
```

Following steps can be version-controlling your configuration and moving your configuration into a .dotfiles directory out of /etc/nixos

