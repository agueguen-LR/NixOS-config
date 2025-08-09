{
  keymaps = [ 
		{
			key = "<C-t>";
			mode = "n";
			action = "<Cmd>ToggleTerm size=15<CR>";
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
  ];
}
