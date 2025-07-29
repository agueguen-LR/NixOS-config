{
  home.persistence."/persist/home/adrien" = {
    directories = [
			{
				directory = ".ssh";
				method = "symlink";
			}
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
