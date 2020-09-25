/* See LICENSE file for copyright and license details. */

/* Constants */
#define TERMINAL "alacritty"
#define TERMCLASS "Alacritty"

/* appearance */
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int snap      = 0;       /* snap pixel */
static const unsigned int gappih    = 30;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 30;       /* vert inner gap between windows */
static const unsigned int gappoh    = 30;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 30;       /* vert outer gap between windows and screen edge */
static const int swallowfloating    = 1;        /* 1 means swallow floating windows by default */
static const int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 0;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const int yoffset            = 70;       /* y-offset */
static const char *fonts[]          = { "monospace:size=12", "JoyPixels:pixelsize=12:antialias=true:autohint=true"  };
static char dmenufont[]             = "monospace:size=12";
static char normbgcolor[]           = "#2c2e34";
static char normbordercolor[]       = "#3b3e48";
static char normfgcolor[]           = "#828a98";
static char selfgcolor[]            = "#c5cdd9";
static char selbordercolor[]        = "#d38aea";
static char selbgcolor[]            = "#6cb6eb";
static char *colors[][3] = {
    /*               fg           bg           border   */
    [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
    [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

typedef struct {
    const char *name;
    const void *cmd;
} Sp;
const char *spcmd1[] = {TERMINAL, "-n", "spterm", "-g", "120x34", NULL };
const char *spcmd2[] = {TERMINAL, "-n", "spcalc", "-f", "monospace:size=16", "-g", "50x20", "-e", "bc", "-lq", NULL };
static Sp scratchpads[] = {
    /* name          cmd  */
    {"spterm",      spcmd1},
    {"spranger",    spcmd2},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
    /* xprop(1):
     *  WM_CLASS(STRING) = instance, class
     *  WM_NAME(STRING) = title
    */
    /* class    instance      title              tags mask    isfloating   isterminal  noswallow  monitor */
    { "Gimp",     NULL,       NULL,                 1 << 8,       0,           0,         0,        -1 },
    { TERMCLASS,   NULL,       NULL,                0,            0,           1,         0,        -1 },
    { NULL,       NULL,       "Event Tester",   0,            0,           0,         1,        -1 },
    { NULL,      "spterm",    NULL,                 SPTAG(0),     1,           1,         0,        -1 },
    { NULL,      "spcalc",    NULL,                 SPTAG(1),     1,           1,         0,        -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"
static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[@]",    spiral },                       /* Fibonacci spiral */
    { "[\\]",   dwindle },                      /* Decreasing in size right and leftward */

    { "|M|",    centeredmaster },               /* Master in middle, slaves on sides */
    { ">M>",    centeredfloatingmaster },       /* Same but master floats */

    { "[]=",    tile },                         /* Master on left, slaves on right */
    { "TTT",    bstack },                       /* Master on top, slaves on bottom */

    { "H[]",    deck },                         /* Master on left, slaves in monocle-like mode on right */
    { "[M]",    monocle },                      /* All windows on top of eachother */

    { "><>",    NULL },                         /* no layout function means floating behavior */
    { NULL,             NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
    { MOD,  XK_j,   ACTION##stack,  {.i = INC(+1) } }, \
    { MOD,  XK_k,   ACTION##stack,  {.i = INC(-1) } }, \
    { MOD,  XK_t,   ACTION##stack,  {.i = 0 } }, \

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "rofi", "-show", "drun", NULL };
static const char *termcmd[]  = { TERMINAL, NULL };

#include <X11/XF86keysym.h>
#include "shiftview.c"
static Key keys[] = {
    /* modifier                 key             function        argument */
    STACKKEYS(MODKEY,                           focus)          /* MOD+j/k/t: focus on lower/upper/top window */
    STACKKEYS(MODKEY|ShiftMask,                 push)           /* MOD+Shift+j/k/t: move current window lower/upper/top */
    { MODKEY,                   XK_z,           spawn,          {.v = dmenucmd } },     /* launch menu */
    { MODKEY,                   XK_Return,      spawn,          {.v = termcmd } },      /* launch terminal */
    { MODKEY,                   XK_w,           killclient,     {0} },                  /* close window */
    { MODKEY,                   XK_equal,       incnmaster,     {.i = +1 } },           /* increase number of windows in master area */
    { MODKEY,                   XK_minus,       incnmaster,     {.i = -1 } },           /* decrease number of windows in master area */
    { MODKEY,                   XK_h,           setmfact,       {.f = -0.05} },         /* decrease master area size */
    { MODKEY,                   XK_l,           setmfact,       {.f = +0.05} },         /* increase master area size */
    { MODKEY,                   XK_f,           togglefullscr,  {0} },                  /* toggle fullscreen window */
    { MODKEY|ShiftMask,         XK_f,           togglefloating, {0} },                  /* toggle floating layout */
    { MODKEY,                   XK_space,       zoom,           {0} },                  /* zooms/cycles focused window to/from master area */
    { MODKEY,                   XK_F1,          setlayout,      {.v = &layouts[0]} },   /* layout: fibonacci spiral */
    { MODKEY|ShiftMask,         XK_F1,          setlayout,      {.v = &layouts[1]} },   /* layout: binary tree */
    { MODKEY,                   XK_F2,          setlayout,      {.v = &layouts[2]} },   /* layout: centered master */
    { MODKEY|ShiftMask,         XK_F2,          setlayout,      {.v = &layouts[3]} },   /* layout: centered floating master */
    { MODKEY,                   XK_F3,          setlayout,      {.v = &layouts[4]} },   /* layout: vertical tile */
    { MODKEY|ShiftMask,         XK_F3,          setlayout,      {.v = &layouts[5]} },   /* layout: horizontal tile */
    { MODKEY,                   XK_F4,          setlayout,      {.v = &layouts[6]} },   /* layout: monocle stacked areas */
    { MODKEY|ShiftMask,         XK_F4,          setlayout,      {.v = &layouts[7]} },   /* layout: monocle all areas */
    { MODKEY,                   XK_Tab,         view,           {0} },                  /* switch tags */
    { MODKEY,                   XK_Page_Up,     shiftview,      { .i = -1 } },          /* switch to previous tag */
    { MODKEY|ShiftMask,         XK_Page_Up,     shifttag,       { .i = -1 } },          /* move current window to previous tag */
    { MODKEY,                   XK_Page_Down,   shiftview,      { .i = +1 } },          /* switch to next tag */
    { MODKEY|ShiftMask,         XK_Page_Down,   shifttag,       { .i = +1 } },          /* move current window to next tag */
    TAGKEYS(                    XK_1,           0)      /* MOD+[0-9]: switch to [0-9] tag; MOD+Shift+[0-9]: move current window to [0-9] tag */
    TAGKEYS(                    XK_2,           1)
    TAGKEYS(                    XK_3,           2)
    TAGKEYS(                    XK_4,           3)
    TAGKEYS(                    XK_5,           4)
    TAGKEYS(                    XK_6,           5)
    TAGKEYS(                    XK_7,           6)
    TAGKEYS(                    XK_8,           7)
    TAGKEYS(                    XK_9,           8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
#ifndef __OpenBSD__
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1} },
    { ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2} },
    { ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3} },
    { ClkStatusText,        0,              Button4,        sigdwmblocks,   {.i = 4} },
    { ClkStatusText,        0,              Button5,        sigdwmblocks,   {.i = 5} },
    { ClkStatusText,        ShiftMask,      Button1,        sigdwmblocks,   {.i = 6} },
#endif
    { ClkStatusText,        ShiftMask,      Button3,        spawn,          SHCMD(TERMINAL " -e nvim ~/.local/src/dwmblocks/config.h") },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        defaultgaps,        {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkClientWin,         MODKEY,         Button4,        incrgaps,       {.i = +1} },
    { ClkClientWin,         MODKEY,         Button5,        incrgaps,       {.i = -1} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
    { ClkTagBar,            0,              Button4,        shiftview,      {.i = -1} },
    { ClkTagBar,            0,              Button5,        shiftview,      {.i = 1} },
    { ClkRootWin,           0,              Button2,        togglebar,      {0} },
};
