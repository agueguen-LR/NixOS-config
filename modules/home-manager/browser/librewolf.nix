{...}: {
  programs.librewolf = {
    enable = true;

    policies.Bookmarks = [
      {
        Title = "NixPkgs";
        URL = "https://search.nixos.org/packages";
        Placement = "toolbar"; # Only needed once per folder
        Folder = "Nix";
      }
      {
        Title = "Home-manager";
        URL = "https://nix-community.github.io/home-manager/options.xhtml";
        Folder = "Nix"; # No need for Placement as folder already placed before
      }
      {
        Title = "Hyprland";
        URL = "https://wiki.hypr.land/";
        Folder = "Nix";
      }
      {
        Title = "NixVim";
        URL = "https://mattsturgeon.github.io/nixvim/";
        Folder = "Nix";
      }
      {
        Title = "GitHub";
        URL = "https://github.com/agueguen-LR";
        Placement = "toolbar";
      }
      {
        Title = "Youtube";
        URL = "https://www.youtube.com/";
        Placement = "toolbar";
      }
    ];

    policies.ExtensionSettings = with builtins; let
      extension = shortId: uuid: {
        name = uuid;
        value = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
          installation_mode = "normal_installed";
        };
      };
    in
      listToAttrs [
        (extension "ublock-origin" "uBlock0@raymondhill.net")
        (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
        (extension "matte-black-red" "{a7589411-c5f6-41cf-8bdc-f66527d9d930}")
        (extension "darkreader" "addon@darkreader.org")
      ];
    # To add additional extensions, find it on addons.mozilla.org, find the short
    # ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # install it, then go to about:debugging#/runtime/this-firefox to find the uuid
    # under Extension ID
  };
}
