//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	  /*Icon*/	/*Command*/		               /*Update Interval*/	/*Update Signal*/
    { "   ",     "~/ownCloud/dotfiles/scripts/status/clock",               20,    },
    { "   ",     "~/ownCloud/dotfiles/scripts/status/weather",             300,   },
    { "   ",     "~/ownCloud/dotfiles/scripts/status/volume",              0,     1 },
    { "   ",     "~/ownCloud/dotfiles/scripts/status/microphone",          0,     2 },
    { "  ",      "~/ownCloud/dotfiles/scripts/status/keyboard",            0,     3 },
    { "  ",      "~/ownCloud/dotfiles/scripts/status/wifinetwork",         5,     4},
    { "   ",     "~/ownCloud/dotfiles/scripts/status/battery",             30,    },
	// {"Mem:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},
  //
	// {"", "date '+%b %d (%a) %I:%M%p'",					5,		0},
    // { "   ",     "~/ownCloud/dotfiles/scripts/status/cpu",                 0,    18 },
    // { "   ",     "~/ownCloud/dotfiles/scripts/status/memory",              0,    19 },
    // { "   ",     "~/ownCloud/dotfiles/scripts/status/disk",                60,   16 },
    // { "   ",     "~/ownCloud/dotfiles/scripts/status/lightlockerstatus",   0,    14 },
    // { "   ",     "~/ownCloud/dotfiles/scripts/status/kblayout",            0,    12 },
    // { "   ",     "~/ownCloud/dotfiles/scripts/ scripts/dwm-bar/bar-functions/dwm_alsa.sh",     0,    10 },
    /* { "  ",     "~/ownCloud/dotfiles/scripts/status/brightness",          0,    11 }, */
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " ";
static unsigned int delimLen = 5;
