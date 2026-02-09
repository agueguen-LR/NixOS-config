{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./dap.nix
    ./keymaps.nix
    ./plugins.nix
    ./lsp.nix
  ];

  programs.nixvim = {
    enable = true;

    opts = {
      number = true;
      relativenumber = true;
      splitright = true;
    };
    globals = {
      mapleader = " ";
    };
    globalOpts = {
      shiftwidth = 2;
      tabstop = 2;
    };

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
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
    '';
  };
}
