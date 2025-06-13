{ pkgs, ... }:  

{

  programs.nvf = {
    enable = true;

    settings.vim = {
      theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
      };

      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;


      lsp.enable = true;
      languages = {
        enableTreesitter = true;

        nix = {
          enable = true;
          lsp.server = "nixd";
        };
      };
    };
  };
}

