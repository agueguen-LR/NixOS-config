{ ... }:  
{
  programs.nvf = {
    enable = true;

    settings.vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
      filetree.neo-tree.enable = true;
      tabline.nvimBufferline.enable = true;
      clipboard = {
        enable = true;
        providers = {
          wl-copy.enable = true;
        };
      };

      options = {
        shiftwidth = 2;
        tabstop = 2;
      };

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

