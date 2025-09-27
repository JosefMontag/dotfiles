//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	  /*Icon*/	/*Command*/		               /*Update Interval*/	/*Update Signal*/
    { "   ",     "~/dotfiles/scripts/status/clock",               1,    },
    { "   ",     "~/dotfiles/scripts/status/weather",             300,   },
    { "   ",     "~/dotfiles/scripts/status/volume",              0,     1 },
    { "   ",     "~/dotfiles/scripts/status/microphone",          0,     2 },
    { "  ",      "~/dotfiles/scripts/status/keyboard",            0,     3 },
    { "  ",      "~/dotfiles/scripts/status/wifinetwork",         1,     4},
    { "   ",     "~/dotfiles/scripts/status/battery",             10,    },
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "";
static unsigned int delimLen = 5;
