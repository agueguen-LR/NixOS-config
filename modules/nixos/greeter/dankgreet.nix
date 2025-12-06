{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    # compositor.name = ""; ! MUST BE SET IN PROFILE !

    # Sync your user's DankMaterialShell theme with the greeter.
    configHome = "/home/${config.hostSpec.username}";

    # Custom config files for non-standard config locations
    configFiles = [
      "/home/${config.hostSpec.username}/.config/DankMaterialShell/settings.json"
    ];

    # Save the logs to a file
    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };
}
