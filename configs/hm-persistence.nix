{
  home.persistence."/persist/adrien" = {
    directories = [
      ".local/share/soh" #Ship of harkinian
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      ".gitconfig"
    ];
    allowOther = true;
  };
}
