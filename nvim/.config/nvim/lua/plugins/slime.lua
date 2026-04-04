-- plugins/slime.lua (or wherever you load your plugins)
return {
  'jpalardy/vim-slime',
  init = function()
    vim.g.slime_target = "zellij"
    vim.g.slime_dont_ask_default = 1
    vim.g.slime_bracketed_paste = 1
    
    -- The strictly required dictionary format for Zellij
    vim.g.slime_default_config = {
        session_id = "current",
        relative_pane = "right",
      relative_move_back = "left"  -- <--- THE MISSING PIECE
    }
  end
}
