return {
    "geg2102/nvim-python-repl",
    ft = {"python", "lua"}, 
    config = function()
        require("nvim-python-repl").setup({
            execute_on_send = true,
            vsplit = false,
          spawn_command={
        python="ipython", 
        lua="ilua"
    }
        })
    end
    }
