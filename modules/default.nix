{
  # Import all modules
  imports = let
    entries = builtins.readDir ./.;
    directories =
      builtins.filter
      (name: entries.${name} == "directory")
      (builtins.attrNames entries);
  in
    map (name: ./. + "/${name}/default.nix") directories;
}
