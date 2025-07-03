{
  keymaps = [ 
    {
      key = "<Esc>";
      mode = "t";
      silent = true;
      action = "<C-\\><C-n>";
    }
    {
      key = "<C-b>";
      mode = "n";
      action = "<Cmd>Neotree toggle action=show<CR>";
    }
    {
      key = "<leader>g";
      mode = "n";
      action = "<Cmd>Neotree git_status position=float<CR>";
    }
  ];
}
