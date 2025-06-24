# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, inputs, outputs, config, lib, ... }:
let
  modules = outputs.nixosModules;
in
{
  imports =
    [ 
      ../../disko/impermanence.nix
      inputs.disko.nixosModules.disko
      inputs.agenix.nixosModules.default
      inputs.impermanence.nixosModules.impermanence
      ../persistence.nix
      modules.home-manager
      modules.neovim
      modules.hyprland
      modules.tuigreet
      modules.zsh
      modules.steam
    ];

  system.nixos.tags = [ "hyprland" ];
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;

  fileSystems."/persist".neededForBoot = true;

  boot.initrd.postDeviceCommands = ''
    zpool import zroot
    zfs rollback -r zroot/local/root@blank
  '';

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 20;
    extraEntries = 
      let
        configDir = ../../savedConfigs;
        files = builtins.attrNames (builtins.readDir configDir);
        confFiles = builtins.filter (f: lib.hasSuffix ".conf" f) files;
      in 
        builtins.listToAttrs (map (name: {name = name; value = builtins.readFile (configDir + "/${name}");}) confFiles);      
  };
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.services.update-latest-configs = {
    enable = true;
    description = "Update the contents of the ../../savedConfigs folder with the latest builds";
    wantedBy = [ "multi-user.target" ];
    script = "exec ${../../savedConfigs/update-latest-configs.sh}";
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    hostId = "c65cfc29";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  # Configure keymap with xwayland
  #services.xserver.xkb = {
    #layout = "fr";
    #options = "eurosign:e,caps:escape";
  #};

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  home-manager.users.adrien = import ./home.nix;

  age = {
    identityPaths = [ "/persist/adrien/.secrets/agenix-rsa-4096" ];
    secrets.user-password.file = ../../secrets/user-password.age;
  };

  users.mutableUsers = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adrien= {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    hashedPasswordFile = config.age.secrets.user-password.path;
    packages = with pkgs; [

      btop
      fastfetch

      alacritty
      pavucontrol #volume control
      tree
      acpi #battery info
      sysstat #system info commands: iostat mpstat pidstat ...
      librewolf

      grimblast #screenshots

      wl-clipboard
      quickemu
    ];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = [
    pkgs.vim
    inputs.home-manager.packages.${pkgs.system}.default
    pkgs.git
  ];

  fonts.packages = with pkgs.nerd-fonts; [
    jetbrains-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  system.stateVersion = "25.05";
}
