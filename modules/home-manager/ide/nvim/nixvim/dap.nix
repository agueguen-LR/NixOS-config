{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins = {
      dap-ui.enable = true;
      dap = {
        enable = true;

        adapters = {
          executables = {};
          servers = {};
        };
      };
    };

    extraConfigLuaPre = ''
      _G.nix = {}
      _G.nix.dap = {
      	  gdb = "${pkgs.gdb}/bin/gdb",
      }
    '';

    extraConfigLua = lib.readFile ./lua/dap.lua;

    extraPlugins = [(pkgs.vimPlugins.telescope-dap-nvim)];
  };
}
