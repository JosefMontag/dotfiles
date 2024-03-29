/* See LICENSE file for copyright and license details. */

// Volume and brightness keys
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 4;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = {"Inconsolata\\-dz:size=13", "IcoFont:size=13", "NotoColorEmoji:size=15", "FontAwesome:size=13"};
static const char dmenufont[]       = "Inconsolata\\-dz:size=13";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#10852f";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

static const char *const autostart[] = {
  "dwmblocks", NULL,
  "chromium", NULL,
  "redshift", "-l", "49:15", NULL,
  "nautilus", NULL,
  "vim", "-g", NULL,
  "owncloud", NULL,
  "insync", "start",  NULL,
  "xautolock", "-locker", "slock", NULL,
	NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	M_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class            instance    title       tags mask  iscentered   isfloating   monitor */
	{ "Google-chrome",  NULL,       NULL,       0 << 0,    0,           0,           -1 },
	{ "Nautilus",         NULL,       NULL,       1 << 1,    0,           0,           -1 },
	{ "Gvim",           NULL,       NULL,       1 << 2,    0,           0,           -1 },
	{ "ownCloud",       NULL,       NULL,       1 << 8,    0,           0,           -1 },
	{ "Insync",         NULL,       NULL,       1 << 8,    0,           0,           -1 },
	{ "dropbox",        NULL,       NULL,       1 << 8,    0,           0,           -1 },
	{ "st",             NULL,       NULL,       0,      1,           0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "[D]",      deck },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "alacritty", NULL };

// #include "selfrestart.c"

static Key keys[] = {
	/* modifier                     key        function        argumen style=Boldt */
	{ MODKEY|ControlMask,           XK_space,  spawn,          {.v = dmenucmd } },
	{ ControlMask|ShiftMask,        XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.03} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.03} },
 	{ MODKEY|ShiftMask,             XK_h,      setcfact,       {.f = +0.25} },
 	{ MODKEY|ShiftMask,             XK_l,      setcfact,       {.f = -0.25} },
 	{ MODKEY|ShiftMask,             XK_o,      setcfact,       {.f =  0.00} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ ControlMask,                  XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
 	{ MODKEY,                       XK_c,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_p,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
    // { MODKEY|ShiftMask,             XK_r,      self_restart,   {0} },
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
 	{ MODKEY|ShiftMask,             XK_r,      quit,           {1} }, 
  // Volume, mic, and brightness keys
  { 0, XF86XK_AudioMute,                     spawn,          SHCMD("~/dotfiles/scripts/status/volume_toggle; pkill -RTMIN+1 dwmblocks") },
  { 0, XF86XK_AudioRaiseVolume,              spawn,          SHCMD("amixer set Master 5%+; pkill -RTMIN+1 dwmblocks") },
  { 0, XF86XK_AudioLowerVolume,              spawn,          SHCMD("amixer set Master 5%-; pkill -RTMIN+1 dwmblocks") }, 
  { 0, XF86XK_AudioMicMute,                  spawn,          SHCMD("amixer set Capture toggle; amixer set Dmic0 toggle; pkill -RTMIN+2 dwmblocks") },
  { 0, XF86XK_MonBrightnessUp,               spawn,          SHCMD("backlight_control +10") },
  { 0, XF86XK_MonBrightnessDown,             spawn,          SHCMD("backlight_control -10") },
  // Keyboard switcher signal
  {ControlMask|ShiftMask,                      XK_space,  spawn,          SHCMD("~/dotfiles/scripts/kbd_change; pkill -RTMIN+3 dwmblocks") },
  // Wifi signal
  { 0, XF86XK_WLAN,                          spawn,          SHCMD("sleep 0.3s;pkill -RTMIN+4 dwmblocks") },
  // Screenshot
  {0, XK_Print,                              spawn,          SHCMD("sleep 0.3s;scrot -s '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f'") },
  // Rofi
  {ControlMask,                   XK_space, spawn,          SHCMD("rofi -show drun -kb-cancel") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button3,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button2,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
