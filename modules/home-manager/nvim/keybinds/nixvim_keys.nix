{
  keymaps = [ 
		{
			key = "<C-t>";
			mode = "n";
			action = "<Cmd>ToggleTerm size=15 name=ToggleTerm<CR>";
			options = {
        desc = "Open ToggleTerm";
      };
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
			options = {
        desc = "Open Neotree";
      };
    }
    {
      key = "<leader>bd";
      mode = "n";
      action = "<Cmd>wa | %bd! | e\# | bd\#<CR>";
      options = {
        desc = "Write and close all buffers, keeps current one open for editing";
      };
    }
		{
      key = "<leader>g";
      mode = "n";
      action = "<Cmd>LazyGit<CR>";
      options = {
        desc = "Open LazyGit";
      };
    }
  ];
}
