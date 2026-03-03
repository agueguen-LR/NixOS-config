{pkgs, ...}: {
  programs.nixvim.lsp.servers = {
    arduino_language_server = {
      enable = true;
      config = {
        cmd = [
          "${pkgs.arduino-language-server}/bin/arduino-language-server"
          "-cli"
          "${pkgs.arduino-cli}/bin/arduino-cli"
          "-clangd"
          "${pkgs.clang-tools}/bin/clangd"
          "-fqbn"
          "esp32:esp32:featheresp32" # You will need to change this to your board's fqdn for this to work
        ];
        root_markers = [
          "shell.nix"
        ];
      };
    };
    clangd = {
      enable = true;
      config.filetypes = [
        "c"
        "cpp"
        "h"
        "inc"
      ];
    };
    java_language_server = {
      enable = true;
      config.cmd = ["${pkgs.java-language-server}/bin/java-language-server"];
    };
    cmake.enable = true;
    lua_ls.enable = true;
    kotlin_language_server = {
      enable = true;
      config.filetypes = ["kotlin"];
      config.onAttach.function = ''
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      '';
    };
    pylsp.enable = true;
    pyright.enable = true;
    nixd.enable = true;
    rust_analyzer.enable = true;
  };
}
