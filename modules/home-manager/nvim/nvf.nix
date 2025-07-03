{ ... }:  
let
  keybinds = import ./keybinds.nix;
in
{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set langmap=zw,wz
    ''; # Swap keys for azerty
  };

  programs.nvf = {
    enable = true;

    settings.vim = {
      keymaps = keybinds.keymaps;

      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      terminal.toggleterm.enable = true;

      statusline.lualine.enable = true;
      telescope.enable = true;
      #autocomplete.nvim-cmp.enable = true;
      filetree.neo-tree.enable = true;
      tabline.nvimBufferline.enable = true;

      binds.whichKey = {
        enable = true;
      };

      mini = {
        ai.enable = true;
        fuzzy.enable = true;
        git.enable = true;
        surround.enable = true;
        completion.enable = true;
      };

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

        clang = { # c and c++
          enable = true;
          lsp.server = "clangd";
        };

        java.enable = true;

        python = {
          enable = true;
          format.enable = true;
        };

      };
    };
  };
}

