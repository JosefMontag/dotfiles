//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	  /*Icon*/	/*Command*/		               /*Update Interval*/	/*Update Signal*/
    { "",     "~/dotfiles/src/dwm_scripts/clock",               1,    },
    { " | ",     "~/dotfiles/src/dwm_scripts/weather",             300,   },
    { " | ",      "~/dotfiles/src/dwm_scripts/keyboard",            0,     3 },
    { " ",     "~/dotfiles/src/dwm_scripts/volume",              0,     1 },
    { " ",     "~/dotfiles/src/dwm_scripts/microphone",          0,     2 },
    { " ",      "~/dotfiles/src/dwm_scripts/wifinetwork",         1,     4},
    { "  ",     "~/dotfiles/src/dwm_scripts/battery",             10,    }
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "";
static unsigned int delimLen = 0;
