//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	  /*Icon*/	/*Command*/		               /*Update Interval*/	/*Update Signal*/
    { "   ",     "~/dotfiles/src/dwm_scripts/status/clock",               1,    },
    { "   ",     "~/dotfiles/src/dwm_scripts/status/weather",             300,   },
    { "   ",     "~/dotfiles/src/dwm_scripts/status/volume",              0,     1 },
    { "   ",     "~/dotfiles/src/dwm_scripts/status/microphone",          0,     2 },
    { "  ",      "~/dotfiles/src/dwm_scripts/status/keyboard",            0,     3 },
    { "  ",      "~/dotfiles/src/dwm_scripts/status/wifinetwork",         0,     4},
    { "   ",     "~/dotfiles/src/dwm_scripts/status/battery",             100,    }
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "";
static unsigned int delimLen = 5;
