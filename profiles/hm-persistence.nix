{config, ...}: {
  home.persistence."/persist/home/${config.hostSpec.username}" = {
    directories = [
      {
        directory = ".ssh";
        method = "symlink";
      }
      ".gnupg"
      {
        directory = ".local/share/soh"; #Ship of harkinian
        method = "symlink";
      }
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
      {
        directory = ".local/share/PrismLauncher";
        method = "symlink";
      }
    ];
    files = [
      ".gitconfig"
    ];
    allowOther = true;
  };
}
