{
  inputs,
  mkFeature,
  config,
  ...
}:
mkFeature config {
  name = "nixvim";

  hmImports = [
    inputs.nixvim.homeModules.nixvim
    ./dap.nix
    ./keymaps.nix
    ./plugins.nix
    ./lsp.nix
  ];

  nixos.programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.programs.nixvim = {
    enable = true;

    opts = {
      number = true;
      relativenumber = true;
      splitright = true;
    };

    globals.mapleader = " ";

    globalOpts = {
      shiftwidth = 2;
      tabstop = 2;
      laststatus = 3;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        color_overrides = {
          mocha = {
            base = "#000000";
            mantle = "#010101";
            crust = "#020202";
          };
        };
      };
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    # Override any filetype-based indentation from formatters
    extraConfigLua = ''
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          vim.opt_local.shiftwidth = 2
          vim.opt_local.tabstop = 2
          vim.opt_local.softtabstop = 2
          end
        })

      local colors = require("catppuccin.palettes").get_palette("mocha")

      -- Vertical and horizontal split separators
      vim.api.nvim_set_hl(0, "WinSeparator", {
        fg = colors.surface1,
        bg = colors.base,
      })
      vim.api.nvim_set_hl(0, "VertSplit", {
        fg = colors.surface1,
        bg = colors.base,
      })
      vim.opt.fillchars = {
        horiz = "─",
        vert = "│",
        horizup = "┴",
        horizdown = "┬",
        vertleft = "┤",
        vertright = "├",
        verthoriz = "┼",
      }
    '';
  };
}
