{
  keymaps = [ 
		{
			key = "<C-t>";
			mode = "n";
			action = "<Cmd>ToggleTerm size=15 name=ToggleTerm<CR>";
		}
    {
      key = "<Esc>";
      mode = "t";
      action = "<C-\\><C-n>";
    }
    {
      key = "<C-b>";
      mode = "n";
      action = "<Cmd>Neotree toggle action=show<CR>";
    }
    {
      key = "<leader>bd";
      mode = "n";
      action = "<Cmd>wa | %bd! | e\# | bd\#<CR>";
      desc = "Write and close all buffers, keeps current one open for editing";
    }
  ];
}
